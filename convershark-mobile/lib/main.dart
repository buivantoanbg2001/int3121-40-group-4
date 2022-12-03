import 'package:convershark/redux/app_state.dart';
import 'package:convershark/redux/reducers.dart';
import 'package:convershark/screens/welcome_screen.dart';
import 'package:convershark/screens/home_screen.dart';
import 'package:convershark/helpers/constains/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:redux/redux.dart';

final _storageBox = Hive.box("storageBox");

void main() async {
  // initalize hive
  await Hive.initFlutter();

  // open the box
  await Hive.openBox("storageBox");

  final Store<AppState> store =
      Store(reducer, initialState: AppState(selectedServer: -1));

  runApp(StoreProvider(store: store, child: const Convershark()));
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
