import 'package:dio/dio.dart';

class CryptoCoinsRepository {
  Future<void> getCoinsList() async {
    print('HERE');
    try {
      final response = await Dio()
          .get('https://65c5-93-175-6-244.ngrok-free.app/hello_world');
      print(response.toString());
    } catch (e) {
      if (e is DioError) {
        // Обработка ошибок Dio
        print('DioError: ${e.type}');
        print('Message: ${e.message}');
        if (e.response != null) {
          print('Response: ${e.response?.data}');
        }
      } else {
        // Обработка других ошибок
        print('Error: $e');
      }
    }
  }
}
