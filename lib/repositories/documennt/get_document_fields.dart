import 'package:dio/dio.dart';
import 'package:my_app/repositories/models/document_list.dart';

Future<List<FieldModel>> getDocumentFields(String documnetOid) async {
  final url =
      'https://6f93-93-175-6-244.ngrok-free.app/documents/$documnetOid/fields';
  final response = await Dio().get(url);
  if ((response.statusCode == 200) || (response.statusCode == 201)) {
    final listFields = ListFieldsResponse.fromJson(response.data);
    return listFields.items;
  } else {
    throw Exception('Failed to load data');
  }
}
