import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FarmerStatusCheck extends StatelessWidget {
  final List<String> missingFields;
  final VoidCallback onPressed;
  const FarmerStatusCheck({Key? key, required this.missingFields,required this.onPressed,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
          title: Text('Missing Documents'),
          content: Text('The following documents are missing:\n${missingFields.join(', ')}'),
          actions: [
            TextButton(
              onPressed: onPressed,
              child: Text('OK'),
            ),
          ],
        );
  }
}
