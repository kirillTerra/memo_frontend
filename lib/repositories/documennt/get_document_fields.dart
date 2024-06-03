import 'package:dio/dio.dart';
import 'package:my_app/repositories/models/document_list.dart';

Future<List<FieldModel>> getDocumentList(String documnetOid) async {
  final url = 'https://a7d0-93-175-6-18.ngrok-free.app/$documnetOid/fields';
  try {
    final response = await Dio().get(url);
    if ((response.statusCode == 200) || (response.statusCode == 201)) {
      final responseData = response.data as Map<String, dynamic>;
      List<FieldModel> fieldList = responseData["items"];
      print('SUCSESS FIELD');
      return fieldList;
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    throw Exception('Failed to load data: $e');
  }
}
