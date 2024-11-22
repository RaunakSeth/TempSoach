import 'package:flutter/material.dart';
import 'package:testing/Model/PersonalDetails.dart';
import 'package:testing/Onboarding_new/photo_upload_screen.dart';

class ConfirmScreen extends StatelessWidget {
  final PersonalDetails details;

  const ConfirmScreen({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              Image.asset('assets/personal_png.png'),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              const Text(
                "Your personal details are\nsuccessfully saved",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.26),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  minimumSize: Size(double.infinity,
                      MediaQuery.of(context).size.height * 0.07),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PhotoUploadScreen(details: details),
                    ),
                  );
                },
                child: const Text(
                  "Continue to Photo Upload",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}