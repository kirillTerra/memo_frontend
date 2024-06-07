import 'package:dio/dio.dart';
import 'package:my_app/repositories/models/document_list.dart';

Future<List<Document>> getDocumentList() async {
  final url = 'https://4e0a-93-175-6-244.ngrok-free.app/documents/';
  try {
    final response = await Dio().get(url);

    if ((response.statusCode == 200) || (response.statusCode == 201)) {
      ResponseData responseData = ResponseData.fromJson(response.data);
      List<Document> documentList = responseData.items;
      return documentList;
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    throw Exception('Failed to load data: $e');
  }
}
