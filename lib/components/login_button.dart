import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String text;
  const LoginButton({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFC700),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
              )
          ),
          onPressed: () {},
          child:  Center(
            child:  Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
