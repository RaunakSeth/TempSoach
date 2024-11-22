// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:testing/ApiManagerClass.dart';
import 'package:testing/Onboarding_new/new_welcome_screen.dart';
import 'otp_screen.dart'; // Import the OtpScreen class

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final ApiManagerClass api = ApiManagerClass();
  final _formKey = GlobalKey<FormState>();

  // Format phone number to include the country code
  String getFormattedPhoneNumber(String phone) {
    if (!phone.startsWith('+91')) {
      return '+91${phone.trim()}';
    }
    return phone;
  }

  // Function to handle login logic
  Future<void> loginUser(BuildContext context) async {
    String formattedPhone = getFormattedPhoneNumber(phoneController.text);

    try {
      bool response = await api.login(phone: formattedPhone);
      if (response) {
        // Navigate to OTP screen on successful login
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpScreen(phoneNumber: formattedPhone),
          ),
        );
      } else {
        Fluttertoast.showToast(
          msg: "Error in Login",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print("Error: $e");
      Fluttertoast.showToast(
        msg: "Something went wrong. Please try again.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevent the layout from resizing
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.16),
                Center(
                  child: Text(
                    'Log-in',
                    style: TextStyle(
                      fontSize: screenHeight * 0.03,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.06),
                Center(
                  child: Text(
                    'Enter your registered phone number',
                    style: TextStyle(
                      fontSize: screenHeight * 0.02,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 100, 99, 99),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Center(
                  child: SizedBox(
                    width: screenWidth * 0.8,
                    child: TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      decoration: const InputDecoration(
                        prefixText: '  +91   ',
                        hintText: '10-digit mobile number',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty || value.length != 10) {
                          return 'Please enter a valid 10-digit phone number';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                Center(
                  child: Text(
                    'By creating an account, I accept the',
                    style: TextStyle(
                      fontSize: screenHeight * 0.02,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 100, 99, 99),
                    ),
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {

                      // Handle terms of service tap
                    },
                    child: Text(
                      'terms of service and privacy policy',
                      style: TextStyle(
                        fontSize: screenHeight * 0.02,
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.24),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => newWelcomeScreen(),
                        ),
                      );
                      // Handle register tap
                    },
                    child: Text(
                      'Don’t have an account? Register',
                      style: TextStyle(
                        fontSize: screenHeight * 0.02,
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    minimumSize: Size(double.infinity, screenHeight * 0.07),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      loginUser(context);
                    }
                  },
                  child: Text(
                    'Get OTP',
                    style: TextStyle(
                      fontSize: screenHeight * 0.024,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}