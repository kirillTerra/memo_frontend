import 'package:flutter/material.dart';

class PersonalAccountScreen extends StatefulWidget {
  @override
  _PersonalAccountScreenState createState() => _PersonalAccountScreenState();
}

class _PersonalAccountScreenState extends State<PersonalAccountScreen> {
  String firstName = '';
  String lastName = '';
  ImageProvider? avatar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль пользователя'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue[100],
                backgroundImage: avatar,
                child: avatar == null
                    ? Icon(Icons.camera_alt, size: 50, color: Colors.blue)
                    : null,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Имя',
                filled: true,
                fillColor: Colors.blue[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  firstName = value;
                });
              },
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Фамилия',
                filled: true,
                fillColor: Colors.blue[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  lastName = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void _pickImage() async {
    // Логика для загрузки изображения, например, через ImagePicker
    // Здесь можно использовать пакеты как image_picker для выбора изображения
    // setState(() {
    //   avatar = ... // Установить выбранное изображение
    // });
  }
}
