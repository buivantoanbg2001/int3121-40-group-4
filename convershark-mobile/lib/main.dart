import 'package:flutter/material.dart';
import 'screens/welcome/welcome_screen.dart';
import 'utils/colors.dart';

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
      home: const WelcomeScreen(),
    );
  }
}
