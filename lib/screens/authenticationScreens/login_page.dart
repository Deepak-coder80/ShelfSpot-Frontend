import 'package:flutter/material.dart';
import 'package:shelfspot/components/alertboxes/signup_alert_box.dart';
import 'package:shelfspot/components/buttonComponents/login_button.dart';
import 'package:shelfspot/components/buttonComponents/signup_text_button.dart';
import 'package:shelfspot/screens/authenticationScreens/adminAuthentication/admin_login_page.dart';
import 'package:shelfspot/screens/authenticationScreens/studentAuthentication/student_signup_page.dart';


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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Image.asset('assets/images/applogo.png'),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Shelf Spot',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                  ),
                ),
              ),
              const SizedBox(
                height: 52,
              ),
              SizedBox(
                height: 80,
                width: 300,
                child: LoginButton(
                  text: 'Login As Admin',
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AdminLoginPage()));
                  },
                ),
              ),
              const SizedBox(
                height: 52,
              ),
              SizedBox(
                height: 80,
                width: 300,
                child: LoginButton(
                  text: 'Login As Student',
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const StudentSignUpPage()));
                  },
                ),
              ),
              const SizedBox(
                height: 52,
              ),
              SignUpTButton(
                text1: 'New to here?',
                text2: 'Sign Up',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SignUpAlertBox()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
