import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final IconData iconData;

  const TextInputField(
      {super.key,
        required this.text,
        required this.controller,
        required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(

        cursorColor: const Color(0xFFFFC700),
        decoration: InputDecoration(
          prefixIcon: Icon(
            iconData,
            size: 24,
            color: const Color(0xFFFFC700),
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(34),
            borderSide: const BorderSide(
              color: Color(0xFFFFC700),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(34),
            borderSide: const BorderSide(
              color: Color(0xFFFFC700),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(34),
            borderSide: const BorderSide(
              color: Color(0xFFFFC700),
            ),
          ),
          hintText: text,
          hintStyle: const TextStyle(
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        controller: controller,
      ),
    );
  }
}