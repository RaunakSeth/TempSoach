import 'package:flutter/material.dart';
import 'package:testing/Model/bank_details_model.dart'; // Import the model class
import 'package:testing/Onboarding_new/bank_confirm.dart';
import 'select_bank.dart';
import 'package:testing/Model/PersonalDetails.dart';

class BankDetails extends StatefulWidget {
  final PersonalDetails personalDetails;
  final String photoBase64;

  const BankDetails({
    Key? key,
    required this.personalDetails,
    required this.photoBase64,
  }) : super(key: key);

  @override
  _BankDetailsState createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
  String selectedBank = '';
  final _formKey = GlobalKey<FormState>();
  final _accountHolderNameController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _reenterAccountNumberController = TextEditingController();
  final _ifscCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.green,
        title: const Text(
          'Bank Details',
          style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: mediaQuery.size.width * 0.05,
            vertical: mediaQuery.size.height * 0.02,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Enter your bank account details',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: mediaQuery.size.height * 0.04),
                Text(
                  'Enter details carefully to avoid verification failure',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.grey[500]),
                ),
                SizedBox(height: mediaQuery.size.height * 0.03),
                const Text(
                  'Select your bank',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: mediaQuery.size.height * 0.01),
                GestureDetector(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SelectBank()),
                    );
                    if (result != null) {
                      setState(() {
                        selectedBank = result;
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: mediaQuery.size.height * 0.02,
                      horizontal: mediaQuery.size.width * 0.04,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedBank.isEmpty ? 'Select Your Bank' : selectedBank,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const Icon(Icons.arrow_right_rounded),
                      ],
                    ),
                  ),
                ),
                if (selectedBank.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Bank selection is required',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                SizedBox(height: mediaQuery.size.height * 0.02),
                _buildTextField(
                  label: "Account Holder's Name",
                  controller: _accountHolderNameController,
                  validator: (value) =>
                  value == null || value.isEmpty ? "Account Holder's Name is required" : null,
                ),
                SizedBox(height: mediaQuery.size.height * 0.02),
                _buildTextField(
                  label: 'Account Number',
                  controller: _accountNumberController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Account Number is required';
                    }
                    if (!RegExp(r'^\d{9,18}$').hasMatch(value)) {
                      return 'Account Number must be between 9 and 18 digits';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: mediaQuery.size.height * 0.02),
                _buildTextField(
                  label: 'Re-enter Account Number',
                  controller: _reenterAccountNumberController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Re-entering Account Number is required';
                    }
                    if (value != _accountNumberController.text) {
                      return 'Account Numbers do not match';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: mediaQuery.size.height * 0.02),
                _buildTextField(
                  label: 'IFSC Code',
                  controller: _ifscCodeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'IFSC Code is required';
                    }
                    if (!RegExp(r'^[A-Za-z]{4}\d{7}$').hasMatch(value)) {
                      return 'Invalid IFSC Code format';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: mediaQuery.size.height * 0.13),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (selectedBank.isEmpty) {
                        setState(() {});
                      } else if (_formKey.currentState!.validate()) {
                        final bankDetails = BankDetailsModel(
                          bankName: selectedBank,
                          accountHolderName: _accountHolderNameController.text,
                          accountNumber: _accountNumberController.text,
                          reEnterAccountNumber: _reenterAccountNumberController.text,
                          ifscCode: _ifscCodeController.text,
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BankConfirmScreen(
                              personalDetails: widget.personalDetails,
                              photoBase64: widget.photoBase64,
                              bankDetails: bankDetails,  // Pass the model here
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      minimumSize: Size(double.infinity, mediaQuery.size.height * 0.07),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      validator: validator,
      keyboardType: keyboardType,
    );
  }
}