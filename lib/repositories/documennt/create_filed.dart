import 'package:dio/dio.dart';
import 'package:my_app/repositories/models/document_list.dart';

Future<FieldModel> createFieldRepository(
    String name, String documentOid) async {
  final url =
      'https://4abe-93-175-6-18.ngrok-free.app/documents/$documentOid/fields';
  try {
    var dio = Dio();
    final response = await dio.post(url, data: {'name': name});

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> responseData = response.data as Map<String, dynamic>;
      FieldModel field = FieldModel(
          oid: responseData["oid"] as String,
          name: name,
          createdAt: '',
          value: '');
      print('DOCUMENID');
      print(field.oid);
      return field;
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    throw Exception('Failed to load data: $e');
  }
}
