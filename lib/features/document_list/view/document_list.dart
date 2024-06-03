import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:my_app/features/document/document.dart';
import 'package:my_app/repositories/document_list/document_list_repository.dart';
import 'package:my_app/features/document_list/widgets/document.dart';
import 'package:my_app/repositories/models/document_list.dart';
import 'package:my_app/repositories/document_list/create_document.dart';
import 'package:my_app/repositories/document_list/delete_document.dart';

// Экран списка документов
class DocumentListScreen extends StatefulWidget {
  @override
  _DocumentListScreenState createState() => _DocumentListScreenState();
}

class _DocumentListScreenState extends State<DocumentListScreen> {
  List<Document> _documents = [];

  @override
  void initState() {
    _loadDocuments();
    super.initState();
  }

  Future<void> _loadDocuments() async {
    _documents = await getDocumentList();
    print('LOAD DOCUMENTS');
    print(_documents.length);
    setState(() {});
  }

  Future<void> _addNewDocument() async {
    String? name = await _showNameInputDialog();
    if (name != null && name.isNotEmpty) {
      Document document = await createDocument(name);
      setState(() {
        _documents.add(document);
      });
    }
  }

  Future<String?> _showNameInputDialog() {
    TextEditingController _textFieldController = TextEditingController();

    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Введите имя документа'),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: "Имя документа"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Отмена'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('ОК'),
              onPressed: () {
                Navigator.pop(context, _textFieldController.text);
              },
            ),
          ],
        );
      },
    );
  }

  void _openDocument(Document document) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DocumentScreen(),
      ),
    );
  }

  void _deleteDocument(Document document) async {
    await deleteDocument(document.oid);
    setState(() {
      _documents.remove(document);
    });
    print("DELTE SUCSESS");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Приемы'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _documents.length + 1,
        itemBuilder: (context, index) {
          if (index == _documents.length) {
            return GestureDetector(
              onTap: _addNewDocument,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6.0,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.add,
                    color: Colors.blue,
                    size: 30,
                  ),
                ),
              ),
            );
          }

          final document = _documents[index];
          return DocumentWidget(
            document: document,
            onTap: () => _openDocument(document),
            onDelete: () => _deleteDocument(document),
          );
        },
      ),
    );
  }
}
