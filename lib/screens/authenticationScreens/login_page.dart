import 'package:flutter/material.dart';
import 'package:shelfspot/components/login_button.dart';
import 'package:shelfspot/components/signup_text_button.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF201F15),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/applogo.png'),
            const Text(
              'Shelf Spot',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 36,
              ),
            ),
            const SizedBox(
              height: 52,
            ),
            const LoginButton(
              text: 'Login As Admin',
            ),
            const SizedBox(
              height: 52,
            ),
            const LoginButton(
              text: 'Login As Student',
            ),
            const SizedBox(
              height: 52,
            ),
            const SignUpTButton()
          ],
        ),
      ),
    );
  }
}

