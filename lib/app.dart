import 'package:chat_app/screens/auth.dart';
import 'package:chat_app/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/utils/themes/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: TText.appName,
      themeMode: ThemeMode.light,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      home: const AuthScreen(),
    );
  }
}
