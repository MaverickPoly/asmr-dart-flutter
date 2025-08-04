import 'package:flutter/material.dart';

class LapText extends StatelessWidget {
  final String text;
  const LapText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.grey.shade800,
        fontSize: 18,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
