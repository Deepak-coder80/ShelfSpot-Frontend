import 'package:flutter/material.dart';

class AdminRequestScreen extends StatelessWidget {
  const AdminRequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF201F15),
      body: Center(
        child: Text(
          'Admin Question Paper Add Request Screen',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
