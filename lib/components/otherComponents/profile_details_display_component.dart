import 'package:flutter/material.dart';


class ProfileDetails extends StatelessWidget {
  final String heading;
  final String content;

  const ProfileDetails({
    super.key,
    required this.heading,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 20,
          ),
          Text(
            heading,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 21,
            ),
          ),
          Expanded(
            child: Text(
              content,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 21,
              ),
            ),
          )
        ],
      ),
    );
  }
}
