import 'package:flutter/material.dart';
import 'package:my_app/features/document/widgets/user_bold.dart';
import 'package:my_app/features/document/widgets/voice_record.dart';

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
        title: Text('Документы'),
      ),
      body: Column(
        children: <Widget>[
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
          FloatingActionButton(
            onPressed: () {
              setState(() {
                userTexts.add(UserBoldData(title: 'Название поля', text: ''));
              });
            },
            child: Icon(Icons.add),
          ),
          SizedBox(height: 20),
          VoiceRecord(),
        ],
      ),
    );
  }
}
