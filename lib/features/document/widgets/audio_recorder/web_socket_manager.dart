import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

class WebSocketManager {
  WebSocketChannel? _channel;
  final void Function(Map<String, dynamic>)
      onMessageReceived; // Поле для callback

  WebSocketManager({required this.onMessageReceived});

  // Открываем соединение с WebSocket
  void openConnection(String documenntOid) {
    String url =
        'ws://4e0a-93-175-6-244.ngrok-free.app/documents/$documenntOid/';
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
      String messageString = utf8.decode(message);
      Map<String, dynamic> data = messageString as Map<String, dynamic>;
      print('Received message from WebSocket: $messageString');
      onMessageReceived(data);
    } catch (e) {
      print('Error processing WebSocket message: $e');
    }
  }

  // Метод для получения потока данных
  Stream<dynamic> get stream => _channel?.stream ?? Stream.empty();
}
