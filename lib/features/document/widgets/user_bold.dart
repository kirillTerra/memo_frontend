import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserBoldData {
  String title;
  String text;

  UserBoldData({required this.title, required this.text});
}

class UserBold extends StatelessWidget {
  final UserBoldData data;
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
                borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      initialValue: data.title,
                      onChanged: (value) {
                        data.title = value;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Введите описание поля',
                        labelText: 'Описание поля',
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: data.text));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Текст скопирован')),
                          );
                        },
                        icon: Icon(Icons.copy),
                        iconSize: 16.0,
                      ),
                      IconButton(
                        onPressed: onDelete,
                        icon: Icon(Icons.close),
                        iconSize: 16.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(10.0)),
              ),
              child: TextFormField(
                initialValue: data.text,
                onChanged: (value) {
                  data.text = value;
                },
                maxLines: null,
                decoration: InputDecoration(
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
