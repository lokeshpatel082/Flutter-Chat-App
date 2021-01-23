import 'package:flutter/material.dart';
import 'package:flutter_chat_app/screens/welcome_screen.dart';
import 'package:flutter_chat_app/screens/login_screen.dart';
import 'package:flutter_chat_app/screens/chat_screen.dart';
import 'package:flutter_chat_app/screens/registration_screen.dart';

void main() {
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark().copyWith(
          textTheme: TextTheme(
            // ignore: deprecated_member_use
            body1: TextStyle(color: Colors.black54),
          ),
        ),
        home: WelcomeScreen(),
        initialRoute: '/login',
        routes: {
          '/welcome': (context) => WelcomeScreen(),
          '/registration': (context) => RegistrationScreen(),
          '/login': (context) => LoginScreen(),
          '/chat': (context) => ChatScreen()
        });
  }
}
