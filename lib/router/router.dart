import 'package:flutter/material.dart';
import 'package:my_app/features/chat/chat.dart';
import 'package:my_app/features/document/document.dart';
import 'package:my_app/features/personal_account/personal_account.dart';
import 'package:my_app/features/document_list/document_list.dart';
import 'package:my_app/repositories/models/document_list.dart';

class AppRouter {
  static const String personalAccount = '/personal_account';
  static const String chat = '/chat';
  static const String document = '/document';
  static const String documentList = '/document_list';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case personalAccount:
        return MaterialPageRoute(builder: (_) => PersonalAccountScreen());
      case chat:
        return MaterialPageRoute(builder: (_) => ChatScreen());
      case document:
        final Document document = settings.arguments as Document;
        return MaterialPageRoute(
          builder: (_) => DocumentScreen(document: document),
        );
      case documentList:
        return MaterialPageRoute(builder: (_) => DocumentListScreen());
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
