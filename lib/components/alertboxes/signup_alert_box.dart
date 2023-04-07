import 'package:flutter/material.dart';
import 'package:shelfspot/screens/authenticationScreens/adminAuthentication/admin_signup_page.dart';

class SignUpAlertBox extends StatelessWidget {
  const SignUpAlertBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF201F15),
      title: const Text(
        'Please select one option to continue',
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AdminSignUpPage()));
          },
          child: const Text(
            'SignUp as Admin',
            style: TextStyle(
              color: Color(0xFFFFC700),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AdminSignUpPage()));
          },
          child: const Text(
            'SignUp as Student',
            style: TextStyle(
              color: Color(0xFFFFC700),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: Color(0xFFFFC700),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
