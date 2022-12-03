import 'package:flutter/material.dart';
import 'package:convershark/screens/signin_screen.dart';
import 'package:convershark/helpers/constains/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: welcomeBackgroundColor,
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Image.asset(
                  "assets/images/welcome_screen_background.jpg",
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: const <Widget>[
                    Text(
                      "Chào mừng bạn đến với Discord",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Tham gia cùng hơn 100 triệu người dùng Discord và trò chuyện với bạn bè và các cộng đồng khác nhau.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: welcomeSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(42),
                  padding: EdgeInsets.zero,
                  backgroundColor: welcomeRegisterButtonColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
                onPressed: () {
                  Fluttertoast.showToast(
                    msg: "Đăng ký",
                    toastLength: Toast.LENGTH_SHORT,
                    timeInSecForIosWeb: 1,
                  );
                },
                child: const Text('Đăng ký'),
              ),
              const SizedBox(
                height: 6,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(42),
                  padding: EdgeInsets.zero,
                  backgroundColor: welcomeLoginButtonColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SigninScreen()),
                  );
                },
                child: const Text('Đăng nhập'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
