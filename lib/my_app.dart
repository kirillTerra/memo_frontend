import 'package:flutter/material.dart';
import 'package:my_app/router/router.dart';
import 'package:my_app/theme/theme.dart';

import 'package:my_app/features/main_page/main_page.dart';

// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      home: MainPage(),
    );
  }
}

