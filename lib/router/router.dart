// import 'package:my_app/features/personal_account/personal_account.dart';
// // import 'package:my_app/features/personal_account/personal_account.dart';

// final routes = {
//   '/': (context) =>  PersonalAccountScreen(),
// };

import 'package:flutter/material.dart';
import 'package:my_app/features/chat/chat.dart';
import 'package:my_app/features/document/document.dart';
import 'package:my_app/features/personal_account/personal_account.dart';

class AppRouter {
  static const String personalAccount = '/personal_account';
  static const String chat = '/chat';
  static const String document = '/document';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case personalAccount:
        return MaterialPageRoute(builder: (_) => PersonalAccountScreen());
      case chat:
        return MaterialPageRoute(builder: (_) => ChatScreen());
      case document:
        return MaterialPageRoute(builder: (_) => DocumentScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Нет маршрута для ${settings.name}'),
            ),
          ),
        );
    }
  }
}