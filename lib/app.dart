/// This file contains the [App] widget which is the root widget of the chat app.
/// It imports [AuthScreen], [ChatScreen], and [SplashScreen] widgets along with
/// [TText] and [TAppTheme] constants from their respective files.
/// The [App] widget is a stateless widget that returns a [MaterialApp] widget.
/// The [MaterialApp] widget has a title, a light theme, a dark theme, and a home
/// widget that is a [StreamBuilder]. The [StreamBuilder] listens to the
/// authentication state changes and returns [SplashScreen] if the connection
/// state is waiting, [ChatScreen] if the user is authenticated, and [AuthScreen]
/// if the user is not authenticated.

import 'package:chat_app/screens/auth.dart';
import 'package:chat_app/screens/chat.dart';
import 'package:chat_app/screens/splash_screen.dart';
import 'package:chat_app/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/utils/themes/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: TText.appName,
      themeMode: ThemeMode.light,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SplashScreen();
            }
            return snapshot.hasData ? const ChatScreen() : const AuthScreen();
          }),
    );
  }
}
