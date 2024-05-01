import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:testing/screens/Login/VerifyScreen.dart';
import 'package:testing/widget/CustomButton.dart';
import 'package:dio/dio.dart';

class Register_Screen extends StatefulWidget {
  const Register_Screen({super.key});

  @override
  State<Register_Screen> createState() => _Register_ScreenState();
}

class _Register_ScreenState extends State<Register_Screen> {
  final TextEditingController phoneController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _panchayatCentreController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _frnNumberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  Country selectedCountry = Country(
    phoneCode: "91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "India",
    example: "example",
    displayName: "India",
    displayNameNoCountryCode: "IN",
    e164Key: "",
  );

  DateTime? _selectedDateOfBirth; // Define _selectedDateOfBirth
  String? _selectedGender; // Define _selectedGender

  Future<void> registerUser(BuildContext context) async {
    try {
      Dio dio = Dio();
      Response response = await dio.post(
        'https://vgfa-backend.onrender.com/api/auth/register',
        data: {
          "phone":"+91"+phoneController.text,
          "first_name": _firstNameController.text,
          "last_name": _lastNameController.text,
          "dob": _dobController.text,
          "panchayat_centre": _panchayatCentreController.text,
          "gender": _genderController.text,
          "frn_number": _frnNumberController.text,
          "address": _addressController.text,
        },
      );

      print(response.data); // For debugging, you can remove this later

      // Access 'type' property accordingly
      if (response.data['type'] == "success") {
        // Navigate to the verification screen if registration is successful
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VerifyScreen(phone: "+91"+phoneController.text,),),
        );
      } else {
        // Handle failure cases if necessary
      }
    } catch (e) {
      print(e.toString()); // Print any errors for debugging
    }
  }
  bool validDate(String value) {
    RegExp regex = RegExp("(0[1-9]|[12][0-9]|3[01])(\/|-)(0[1-9]|1[1,2])(\/|-)(19|20)\d{2}");
    return (!regex.hasMatch(value)) ? false : true;
  }
  @override
  Widget build(BuildContext context) {
    phoneController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: phoneController.text.length,
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
            child: Column(
              children: [
                const Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Add your phone number. We'll send you a verification code",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  cursorColor: Colors.green,
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                  ],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  onChanged: (value) {
                    setState(() {
                      phoneController.text = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Enter phone number",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.grey.shade600,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black12),
                    ),
                    prefixIcon: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          showCountryPicker(
                            context: context,
                            countryListTheme: CountryListThemeData(
                              bottomSheetHeight: MediaQuery.of(context).size.height * 0.8, // Adjust the height here
                            ),
                            onSelect: (value) {
                              setState(() {
                                selectedCountry = value;
                              });
                            },
                          );
                        },
                        child: Text(
                          "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    suffixIcon: phoneController.text.length > 9
                        ? Container(
                      height: 30,
                      width: 30,
                      margin: const EdgeInsets.all(10.0),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                      child: const Icon(
                        Icons.done,
                        color: Colors.white,
                        size: 20,
                      ),
                    )
                        : null,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Form(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            controller: _firstNameController,
                            keyboardType: TextInputType.name,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]'))
                            ],
                            decoration: InputDecoration(
                              labelText: 'First Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.black12),
                              ), // apply border to text field
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter first name';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              // Not implemented yet
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _lastNameController,
                            keyboardType: TextInputType.name,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]'))
                            ],
                            decoration: InputDecoration(
                              labelText: 'Last Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.black12),
                              ), // apply border to text field
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter last name';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              // Not implemented yet
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _dobController,
                            decoration: InputDecoration(
                              labelText: 'Date of Birth',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.black12),
                              ), // apply border to text field
                            ),
                            onTap: () async {
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: _selectedDateOfBirth ?? DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );
                              if (picked != null && picked != _selectedDateOfBirth) {
                                setState(() {
                                  _selectedDateOfBirth = picked;
                                  _dobController.text = DateFormat('dd-MM-yyyy').format(picked); // Format the date
                                });
                              }
                            },

                            validator: (value) {
                              if (value!.isEmpty && validDate(value)) {
                                return 'Please enter date of birth';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              // Not implemented yet
                            },
                          ),
                          const SizedBox(height: 10),
                          DropdownButtonFormField<String>(
                            value: _selectedGender,
                            decoration: InputDecoration(
                              labelText: 'Gender',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.black12),
                              ), // apply border to dropdown
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedGender = newValue;
                                _genderController.text = newValue!;
                              });
                            },
                            items: <String>['Male', 'Female', 'Other']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _panchayatCentreController,
                            keyboardType: TextInputType.name,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]'))
                            ],
                            decoration: InputDecoration(
                              labelText: 'Panchayat Centre',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.black12),
                              ), // apply border to text field
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter Panchayat Centre';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              // Not implemented yet
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _frnNumberController,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                            ],
                            decoration: InputDecoration(
                              labelText: 'FRN Number',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.black12),
                              ), // apply border to text field
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter FRN Number';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              // Not implemented yet
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _addressController,
                            decoration: InputDecoration(
                              labelText: 'Address',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.black12),
                              ), // apply border to text field
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter address';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              // Not implemented yet
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: CustomButton(
                    text: "Register",
                    onPressed: () => registerUser(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
