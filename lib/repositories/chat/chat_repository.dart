import 'package:dio/dio.dart';

class ChatAgent {
  Future<String?> sendMessage(String message) async {
    try {
      final response = await Dio().post(
        'https://ce01-93-175-6-244.ngrok-free.app/echo',
        data: {'message': message},
      );
      // Предполагается, что ответ содержит ключ 'message'
      if (response.data != null && response.data['message'] != null) {
        return response.data['message'];
      } else {
        return 'No message in response';
      }
    } catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          print('Response: ${e.response?.data}');
        }
        return 'DioError: ${e.message}';
      } else {
        // Обработка других ошибок
        print('Error: $e');
        return 'Error: $e';
      }
    }
  }
}
