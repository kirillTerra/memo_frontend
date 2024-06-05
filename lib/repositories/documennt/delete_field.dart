import 'package:dio/dio.dart';

Future<void> deleteFiled(String documentOid, String fieldOid) async {
  print('START DELETE FIELD');
  final url =
      'https://4abe-93-175-6-18.ngrok-free.app/documents/$documentOid/fields?field_oid=$fieldOid';
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
