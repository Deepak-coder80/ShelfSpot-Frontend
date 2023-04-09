import 'package:flutter/material.dart';

class AdminQnPaperScreen extends StatelessWidget {
  const AdminQnPaperScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF201F15),
      body: Center(
        child: Text(
          'Admin Question Paper Management Screen',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
