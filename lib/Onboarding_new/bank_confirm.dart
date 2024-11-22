import 'package:flutter/material.dart';
import 'package:testing/Model/PersonalDetails.dart';
import 'package:testing/Model/bank_details_model.dart';
import 'package:testing/Onboarding_new/document_upload.dart';

class BankConfirmScreen extends StatelessWidget {
  final PersonalDetails personalDetails;
  final String photoBase64;
  final BankDetailsModel bankDetails;

  const BankConfirmScreen({
    Key? key,
    required this.personalDetails,
    required this.photoBase64,
    required this.bankDetails
  }) : super(key: key);

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
                "Your bank details are\nsuccessfully saved",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.26),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  minimumSize: Size(double.infinity, MediaQuery.of(context).size.height * 0.07),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DocumentUploadPage(
                        personalDetails: personalDetails,
                        photoBase64: photoBase64,
                        bankDetails: bankDetails,
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Continue to Document Upload",
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}