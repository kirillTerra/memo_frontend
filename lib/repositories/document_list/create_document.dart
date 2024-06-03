import 'package:dio/dio.dart';
import 'package:my_app/repositories/models/document_list.dart';

// Future<Document> createDocument(String name) async {
//   print('START CREATE DOCUMENT');
//   final url = 'https://a7d0-93-175-6-18.ngrok-free.app/documents/therapist/';
//   try {
//     var dio = Dio();
//     final response = await dio.post(url, data: {'name': name});
//     print('STATUS $response.statusCode');
//     if (response.statusCode == 200) {
//       print("OKEY");
//       print(response.data.name);
//       final document = response.data as Document;
//       print('createdoc');
//       print(document.name);
//       return document;
//     } else {
//       throw Exception('Failed to load data');
//     }
//   } catch (e) {
//     throw Exception('Failed to load data: $e');
//   }
// }

import 'package:dio/dio.dart';
import 'package:my_app/repositories/models/document_list.dart';

Future<Document> createDocument(String name) async {
  final url = 'https://a7d0-93-175-6-18.ngrok-free.app/documents/therapist/';
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
