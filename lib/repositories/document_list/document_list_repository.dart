import 'package:dio/dio.dart';
import 'package:my_app/repositories/models/document_list.dart';

Future<List<Document>> getDocumentList() async {
  print('START');
  final url = 'https://a7d0-93-175-6-18.ngrok-free.app/documents/';
  try {
    var dio = Dio();
    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final data = response.data as ResponseData;
      final documentList = data.items as List<Document>;
      return documentList;
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    throw Exception('Failed to load data: $e');
  }
}
