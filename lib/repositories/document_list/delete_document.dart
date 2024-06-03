import 'package:dio/dio.dart';
import 'package:my_app/repositories/models/document_list.dart';

Future<void> deleteDocument(String documentOid) async {
  print('START DELETE DOCUMENT');
  final url = 'https://a7d0-93-175-6-18.ngrok-free.app/documents/$documentOid';
  print('URL: $url');
  try {
    var dio = Dio();
    final response = await dio.delete(url);
    print('STATUS ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 204) {
      print("Document deleted successfully");
    } else {
      throw Exception('Failed to delete document');
    }
  } catch (e) {
    throw Exception('Failed to delete document: $e');
  }
}
