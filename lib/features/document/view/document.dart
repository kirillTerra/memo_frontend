import 'package:flutter/material.dart';
import 'package:my_app/features/document/widgets/user_bold.dart';
import 'package:my_app/features/document/widgets/voice_record.dart';
import 'package:my_app/features/document/widgets/add_user_bold_button.dart';

class DocumentScreen extends StatefulWidget {
  @override
  _DocumentScreenState createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  List<UserBoldData> userTexts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Устанавливаем стандартную высоту панели инструментов
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
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: userTexts.length,
                  itemBuilder: (context, index) {
                    return UserBold(
                      key: Key('${userTexts[index].hashCode}'),
                      data: userTexts[index],
                      onDelete: () {
                        setState(() {
                          userTexts.removeAt(index);
                        });
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
              onPressed: () {
                setState(() {
                  userTexts.add(UserBoldData(title: '', text: ''));
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
