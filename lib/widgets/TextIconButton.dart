import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextIconButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Widget icon;
  const TextIconButton({super.key, required this.text, required this.onPressed, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          text,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 30,
            ),
        ),
        SizedBox(width: 2), // Add some space between the text and the icon
        IconButton(
          icon: icon,
          onPressed: onPressed,
        ),
      ],
    );
  }
}