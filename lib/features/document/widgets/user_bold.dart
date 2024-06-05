import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/repositories/models/document_list.dart';
import 'package:my_app/repositories/documennt/delete_field.dart';

class UserBold extends StatelessWidget {
  final FieldModel data;
  final VoidCallback onDelete;

  UserBold({required Key key, required this.data, required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10.0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      data.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: data.value));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Текст скопирован')),
                          );
                        },
                        icon: const Icon(Icons.copy),
                        iconSize: 16.0,
                      ),
                      IconButton(
                        onPressed: onDelete,
                        icon: const Icon(Icons.close),
                        iconSize: 16.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(10.0)),
              ),
              child: TextFormField(
                initialValue: data.value,
                onChanged: (value) {
                  data.value = value;
                },
                maxLines: null,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Введите текст',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
