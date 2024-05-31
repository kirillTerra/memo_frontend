import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String text;
  final Widget avatar;
  final bool isHuman;

  const Message(
      {required this.text, required this.avatar, required this.isHuman});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment:
            isHuman ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isHuman) avatar,
          if (!isHuman) SizedBox(width: 8),
          Flexible(
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isHuman ? Colors.blue : Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                text,
                style: TextStyle(color: isHuman ? Colors.white : Colors.black),
              ),
            ),
          ),
          if (isHuman) SizedBox(width: 8),
          if (isHuman) avatar,
        ],
      ),
    );
  }
}

class HumanMessage extends Message {
  HumanMessage({required String text})
      : super(
          text: text,
          avatar: CircleAvatar(
            child: Icon(Icons.person),
          ),
          isHuman: true,
        );
}

class BotMessage extends Message {
  BotMessage({required String text})
      : super(
          text: text,
          avatar: CircleAvatar(
            child: Icon(Icons.android),
          ),
          isHuman: false,
        );
}
