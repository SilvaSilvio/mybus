import 'package:flutter/material.dart';

class Icons extends StatelessWidget {
  final Icon icon;
  final String text;

  Icons(this.icon, this.text);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white24,
            width: 0.5,
          ),
        ),
      ),
      
      );
  }
}