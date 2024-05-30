
import 'package:flutter/material.dart';

import 'package:my_app/features/chat/chat.dart';
import 'package:my_app/features/document/document.dart';
import 'package:my_app/features/personal_account/personal_account.dart';


class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    PersonalAccountScreen(),
    ChatScreen(),
    DocumentScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Colors.blue[100],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black.withOpacity(0.6),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Аккаунт',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Чат',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Документы',
          ),
        ],
      ),
    );
  }
}

