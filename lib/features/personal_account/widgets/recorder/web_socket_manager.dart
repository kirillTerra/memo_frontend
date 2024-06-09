import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

class WebSocketManager {
  WebSocketChannel? _channel;

  // Открываем соединение с WebSocket
  void openConnection(String url) {
    if (_channel != null) return;

    _channel = WebSocketChannel.connect(
      Uri.parse(url),
    );

    // Слушаем входящие сообщения
    _channel!.stream.listen((message) {
      _handleMessage(message);
    });
  }

  // Закрываем соединение с WebSocket
  void closeConnection() async {
    if (_channel != null) {
      await _channel!.sink.close();
      _channel = null;
    }
  }

  // Отправка данных в WebSocket
  void sendData(List<int> data) {
    _channel?.sink.add(data);
  }

  // Обработка входящих сообщений
  void _handleMessage(dynamic message) {
    try {
      String messageJson = utf8.decode(message);
      print('Received message from WebSocket: $messageJson');
      // Здесь можно добавить обработку сообщения
      // Например, обновить какой-то буфер или вызвать callback
    } catch (e) {
      print('Error processing WebSocket message: $e');
    }
  }

  // Метод для получения потока данных
  Stream<dynamic> get stream => _channel?.stream ?? Stream.empty();
}
