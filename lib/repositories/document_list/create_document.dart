import 'package:dio/dio.dart';
import 'package:my_app/repositories/models/document_list.dart';

Future<Document> createDocument(String name) async {
  final url = 'https://6f93-93-175-6-244.ngrok-free.app/documents/therapist/';
  try {
    var dio = Dio();
    final response = await dio.post(url, data: {'name': name});

    if (response.statusCode == 200 || response.statusCode == 201) {
      Document document = Document.fromJson(response.data);
      print('DOCUMENID');
      print(document.oid);
      return document;
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    throw Exception('Failed to load data: $e');
  }
}
