import 'package:flutter/material.dart';

class StudentBookPage extends StatelessWidget {
  const StudentBookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor:  Color(0xFF201F15),
      body: Center(
        child: Text('book Page')
      ),
    );
  }
}
