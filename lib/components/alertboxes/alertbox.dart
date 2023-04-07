import 'package:flutter/material.dart';

class AlertBox extends StatelessWidget {
  final String title;
  final String content;

  const AlertBox({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF201F15),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      content: Text(
        content,
        style: const TextStyle(color: Colors.white),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'OK',
            style: TextStyle(color: Color(0xFFFFC700)),
          ),
        )
      ],
    );
  }
}
