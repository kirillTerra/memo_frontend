import 'package:flutter/material.dart';

import 'package:my_app/features/chat/chat.dart';
// import 'package:my_app/features/document/document.dart';
import 'package:my_app/features/personal_account/personal_account.dart';
import 'package:my_app/features/document_list/document_list.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    ChatScreen(),
    DocumentListScreen(),
    PersonalAccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            child: Container(
              height: 70.0, // Увеличим высоту контейнера
              decoration: BoxDecoration(
                color: Colors.blue[100],
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                backgroundColor: Colors.transparent,
                elevation: 0,
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.black.withOpacity(0.6),
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.chat, size: 24),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.description, size: 24),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person, size: 24),
                    label: '',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
