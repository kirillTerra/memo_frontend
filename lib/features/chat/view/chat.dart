import 'package:flutter/material.dart';
import 'package:my_app/features/chat/widgets/messages.dart';
import 'package:my_app/repositories/chat/chat_repository.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _messageController = TextEditingController();
  List<Widget> _chatHistory = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10.0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _chatHistory.length,
              itemBuilder: (context, index) {
                return _chatHistory[index];
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Введите сообщение...',
                    ),
                    onSubmitted: _sendMessage,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _sendMessage(_messageController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage(String message) async {
    if (message.isNotEmpty) {
      setState(() {
        _chatHistory.insert(
          0,
          HumanMessage(text: message),
        );
        _messageController.clear();
      });
    }
    final botAnswer = await ChatAgent().sendMessage(message);
    setState(() {
      _chatHistory.insert(
        0,
        BotMessage(text: 'Ответ: $botAnswer'),
      );
    });
  }
}
