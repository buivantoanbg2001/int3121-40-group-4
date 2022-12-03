import 'package:convershark/screens/welcome/welcome_screen.dart';
import 'package:convershark/screens/home/home_screen.dart';
import 'package:convershark/helpers/constains/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

final _storageBox = Hive.box("storageBox");

void main() async {
  // initalize hive
  await Hive.initFlutter();

  // open the box
  await Hive.openBox("storageBox");

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
        textTheme: GoogleFonts.kanitTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: _storageBox.get("accessToken") != null
          ? const HomeScreen()
          : const WelcomeScreen(),
    );
  }
}
