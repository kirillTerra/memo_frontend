import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/repositories/models/document_list.dart';

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
          color: Colors.blue[200], // Светло-синий фон
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Тень
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Верхняя часть с заголовком
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: Colors.blue[200], // Синий цвет
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(15.0)),
              ),
              height:
                  30, // Установка фиксированной высоты для уменьшения размера
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      data.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0, // Уменьшенный размер текста
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
                        iconSize: 14.0, // Уменьшенный размер иконки
                        padding: EdgeInsets.zero, // Убираем внутренние отступы
                        constraints:
                            BoxConstraints(), // Убираем ограничения на размер
                      ),
                      IconButton(
                        onPressed: onDelete,
                        icon: const Icon(Icons.close),
                        iconSize: 14.0, // Уменьшенный размер иконки
                        padding: EdgeInsets.zero, // Убираем внутренние отступы
                        constraints:
                            BoxConstraints(), // Убираем ограничения на размер
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Нижняя часть с содержимым
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(15.0), // Закругляем все углы
                border: Border.all(
                  color: Colors.blue[200]!, // Цвет рамки для текстового поля
                  width: 7.0, // Толщина рамки
                ),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                data.value.isEmpty ? '...' : data.value,
                style: const TextStyle(
                  fontSize: 13.0,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
