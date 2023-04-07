import 'package:flutter/material.dart';
import 'package:shelfspot/screens/authenticationScreens/adminAuthentication/admin_signup_page.dart';

class SignUpTButton extends StatelessWidget {
  final String text1;
  final String text2;
  final VoidCallback onPressed;
  const SignUpTButton({
    super.key,
    required this.text1,
    required this.text2,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
         Text(
          text1,
          style:const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(
          width: 3,
        ),
        TextButton(
          onPressed: onPressed,
          child:  Text(
            text2,
            style: const TextStyle(
              color: Color(0xFFFFC700),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
