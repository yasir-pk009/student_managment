import 'package:flutter/material.dart';

class NewText extends StatelessWidget {
  const NewText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      child: Material(
        elevation: 4.0, // Adjust the elevation as needed
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Enter text here',
            contentPadding: EdgeInsets.all(16.0),
            border: InputBorder.none, // Remove border
          ),
        ),
      ),
    );
  }
}