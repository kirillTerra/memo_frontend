import 'package:flutter/material.dart';
import 'package:my_app/features/document/widgets/user_bold.dart';
import 'package:my_app/features/document/widgets/voice_record.dart';
import 'package:my_app/features/document/widgets/add_user_bold_button.dart';
import 'package:my_app/repositories/models/document_list.dart';
import 'package:my_app/repositories/documennt/get_document_fields.dart';
import 'package:my_app/repositories/documennt/create_filed.dart';
import 'package:my_app/repositories/documennt/delete_field.dart';

class DocumentScreen extends StatefulWidget {
  final Document document;
  const DocumentScreen({required this.document});

  @override
  _DocumentScreenState createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  List<FieldModel> userTexts = [];

  @override
  void initState() {
    super.initState();
    // Инициализация на основе переданного документа
    userTexts = widget.document.fields;
    _loadDocumentFields();
  }

  Future<void> _loadDocumentFields() async {
    userTexts = await getDocumentFields(widget.document.oid);
    setState(() {});
  }

  void _addUserBold(String name) async {
    FieldModel field = await createFieldRepository(name, widget.document.oid);
    setState(() {
      userTexts.add(field);
    });
  }

  Future<void> _showAddTitleDialog() async {
    final TextEditingController controller = TextEditingController();

    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Введите название поля'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: "Название поля"),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(controller.text);
              },
              child: const Text('ОК'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Отмена'),
            ),
          ],
        );
      },
    );

    if (result != null && result.isNotEmpty) {
      _addUserBold(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Устанавливаем стандартную высоту панели инструментов
        title: Text(widget.document.name),
        toolbarHeight: kToolbarHeight,
        // Добавляем кнопку "назад"
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // Устанавливаем цвет фона AppBar, чтобы он совпадал с дизайном (если необходимо)
      ),
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              VoiceRecord(),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: userTexts.length,
                  itemBuilder: (context, index) {
                    return UserBold(
                      key: Key('${userTexts[index].hashCode}'),
                      data: userTexts[index],
                      onDelete: () {
                        _handleDelete(index, userTexts[index], widget.document);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom:
                0.0, // Отступ от нижней части экрана, чтобы кнопка была над панелью навигации
            left: 0,
            right: 0,
            child: AddUserBoldButton(
              onPressed: _showAddTitleDialog,
            ),
          ),
        ],
      ),
    );
  }

  void _handleDelete(int index, FieldModel field, Document document) {
    deleteFiled(document.oid, field.oid);
    setState(() {
      userTexts.removeAt(index);
    });
    // Выполнение вашей функции перед удалением
    // Удаление элемента
  }
}
