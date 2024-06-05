class FieldModel {
  final String oid;
  String name;
  final String createdAt;
  String value;

  FieldModel({
    required this.oid,
    required this.name,
    required this.createdAt,
    required this.value,
  });

  factory FieldModel.fromJson(Map<String, dynamic> json) {
    return FieldModel(
      oid: json['oid'],
      name: json['name'],
      createdAt: json['created_at'],
      value: json['value'],
    );
  }
}

// Модель для парсинга элементов
class Document {
  final String oid;
  final String name;
  final String createdAt;
  final List<FieldModel> fields;

  Document({
    required this.oid,
    required this.name,
    required this.createdAt,
    required this.fields,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    var fieldsFromJson = json['fields'] as List;
    List<FieldModel> fieldsList =
        fieldsFromJson.map((field) => FieldModel.fromJson(field)).toList();

    return Document(
      oid: json['oid'],
      name: json['name'],
      createdAt: json['created_at'],
      fields: fieldsList,
    );
  }
}

// Модель для основного ответа
class ResponseData {
  final int count;
  final int offset;
  final int limit;
  final List<Document> items;

  ResponseData({
    required this.count,
    required this.offset,
    required this.limit,
    required this.items,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    var itemsFromJson = json['items'] as List;
    List<Document> itemsList =
        itemsFromJson.map((item) => Document.fromJson(item)).toList();

    return ResponseData(
      count: json['count'],
      offset: json['offset'],
      limit: json['limit'],
      items: itemsList,
    );
  }
}

class ListFieldsResponse {
  final int count;
  final int offset;
  final int limit;
  final List<FieldModel> items;

  ListFieldsResponse({
    required this.count,
    required this.offset,
    required this.limit,
    required this.items,
  });

  factory ListFieldsResponse.fromJson(Map<String, dynamic> json) {
    var itemsJson = json['items'] as List;
    List<FieldModel> itemsList =
        itemsJson.map((item) => FieldModel.fromJson(item)).toList();

    return ListFieldsResponse(
      count: json['count'],
      offset: json['offset'],
      limit: json['limit'],
      items: itemsList,
    );
  }
}
