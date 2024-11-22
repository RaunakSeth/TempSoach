import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testing/Model/PersonalDetails.dart';
import 'package:testing/Onboarding_new/personal_confirm.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({Key? key}) : super(key: key);

  @override
  _PersonalDetailsScreenState createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _aadharCardController = TextEditingController();
  final TextEditingController _frnController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _farmSizeController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  // Variables for dropdown fields
  String? _selectedGender;
  String? _selectedPanchayat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "Personal Details",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 28,
          ),
        ),
        toolbarHeight: 80,
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabel("First Name"),
                _buildTextField(
                  controller: _firstNameController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                      return 'First Name must contain alphabets only.';
                    }
                    return null;
                  },
                ),
                _buildLabel("Last Name"),
                _buildTextField(
                  controller: _lastNameController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                      return 'Last Name must contain alphabets only.';
                    }
                    return null;
                  },
                ),
                _buildLabel("Address"),
                _buildTextField(
                  controller: _addressController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.length < 10) {
                      return 'Address must be at least 10 characters long.';
                    }
                    return null;
                  },
                ),
                _buildLabel("Date of Birth"),
                _buildDatePickerField(),
                _buildLabel("Gender"),
                _buildDropdownField(
                  ["Male", "Female", "Other"],
                      (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                ),
                _buildLabel("Phone Number"),
                _buildTextField(
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                _buildLabel("Aadhar Card Number"),
                _buildTextField(
                  controller: _aadharCardController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                _buildLabel("FRN Number"),
                _buildTextField(
                  controller: _frnController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.length != 13) {
                      return 'FRN Number must be exactly 13 digits.';
                    }
                    return null;
                  },
                ),
                _buildLabel("Panchayat Name"),
                _buildDropdownField(
                  ["Panchayat 1", "Panchayat 2", "Panchayat 3"],
                      (value) {
                    setState(() {
                      _selectedPanchayat = value;
                    });
                  },
                ),
                _buildLabel("Email"),
                _buildTextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                _buildLabel("Farm Size"),
                _buildTextField(
                  controller: _farmSizeController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                _buildLabel("Year Of Experience"),
                _buildTextField(
                  controller: _experienceController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      minimumSize: Size(
                        double.infinity,
                        MediaQuery.of(context).size.height * 0.07,
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final personalDetails = PersonalDetails(
                          firstName: _firstNameController.text,
                          lastName: _lastNameController.text,
                          dateOfBirth: _dobController.text,
                          gender: _selectedGender ?? '',
                          phoneNumber: _phoneNumberController.text,
                          aadharCardNumber: _aadharCardController.text,
                          frnNumber: _frnController.text,
                          panchayatName: _selectedPanchayat ?? '',
                          email: _emailController.text,
                          farmSize: _farmSizeController.text,
                          yearsOfExperience: _experienceController.text,
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ConfirmScreen(details: personalDetails),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      "Continue to Personal Details",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
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

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required TextInputType keyboardType,
    required FormFieldValidator<String> validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        validator: validator,
      ),
    );
  }

  Widget _buildDatePickerField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: _dobController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () async {
              final selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (selectedDate != null) {
                setState(() {
                  _dobController.text =
                      DateFormat('dd-MM-yyyy').format(selectedDate);
                });
              }
            },
          ),
        ),
        readOnly: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select a valid date of birth';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDropdownField(
      List<String> items,
      ValueChanged<String?> onChanged,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
        items: items
            .map((item) => DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
        onChanged: onChanged,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select a value';
          }
          return null;
        },
      ),
    );
  }
}