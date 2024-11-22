import 'package:flutter/material.dart';
import 'package:testing/Onboarding_new/personal_details_screen.dart';

class newWelcomeScreen extends StatelessWidget {
  const newWelcomeScreen({super.key});

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
              SizedBox(height: MediaQuery.of(context).size.height*0.1),
              const Text(
                "Welcome to\nSoach Global!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.1),
              Image.asset('assets/newWelcome.png'),
              SizedBox(height: MediaQuery.of(context).size.height*0.05),
              const Text(
                "Let's get started on registering your\nfarm and connecting with a wider\nmarket.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.2),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    minimumSize: Size(double.infinity, MediaQuery.of(context).size.height* 0.07),
                  ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PersonalDetailsScreen()),
                  );
                },
                child: const Text("Continue to Personal Details",
                style: TextStyle(color: Colors.white,fontSize: 20, fontWeight: FontWeight.w400),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

