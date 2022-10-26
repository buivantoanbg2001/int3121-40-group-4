import 'package:app/screens/chat_screen.dart';
import 'package:app/utils/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Convershark());
}

class Convershark extends StatelessWidget {
  const Convershark({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome Discord',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
      ),
      home: const ChatScreen(),
    );
  }
}
