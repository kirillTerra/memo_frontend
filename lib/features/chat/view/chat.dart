import 'package:flutter/material.dart';

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
        title: Text('Чат'),
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

  void _sendMessage(String message) {
    if (message.isNotEmpty) {
      setState(() {
        _chatHistory.insert(
          0,
          HumanMessage(text: message),
        );
        _chatHistory.insert(
          0,
          BotMessage(text: message),
        );
        _messageController.clear();
      });
    }
  }
}

class Message extends StatelessWidget {
  final String text;
  final Widget avatar;

  const Message({required this.text, required this.avatar});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          avatar,
          SizedBox(width: 8),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
          ),
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
        );
}

class BotMessage extends Message {
  BotMessage({required String text})
      : super(
          text: text,
          avatar: CircleAvatar(
            child: Icon(Icons.android),
          ),
        );
}
