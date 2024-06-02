import 'package:flutter/material.dart';

class DocumentUploadView extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onPressed;
  final String buttonText;
  final Widget icon;

  DocumentUploadView({
    required this.title,
    required this.description,
    required this.onPressed,
    required this.buttonText,
    required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            description,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 16.0),
          SizedBox(
            width: double.infinity,
            height: 50, // Match the height of CustomButton if necessary
            child: ElevatedButton.icon(
              onPressed: onPressed,
              icon: icon,
              label: Text(buttonText),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}