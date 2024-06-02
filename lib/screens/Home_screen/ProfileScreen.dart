import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testing/ApiManagerClass.dart';
import 'package:testing/screens/WelcomeScreen.dart';
import 'dart:io';
import 'package:testing/widget/CustomButton.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );
  ApiManagerClass api = ApiManagerClass();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _firstNameController = TextEditingController(text: 'John');
  TextEditingController _lastNameController = TextEditingController(text: 'Doe');
  TextEditingController _dobController = TextEditingController(text: '01/01/1990');
  TextEditingController _genderController = TextEditingController(text: 'Male');
  TextEditingController _panchayatController = TextEditingController(text: 'Panchayat Name');
  TextEditingController _centreController = TextEditingController(text: 'Centre Name');
  TextEditingController _frnNumberController = TextEditingController(text: '123456789');
  TextEditingController _addressController = TextEditingController(text: '123 Street, City, Country');
  String phone = "";
  bool _isEditing = false;

  File? _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await profileValues();
  }

  Future<void> profileValues() async {
    try {
      var response = await api.data();
      _firstNameController.text = response.firstName!;
      _lastNameController.text = response.lastName!;
      _dobController.text = response.dob!;
      _genderController.text = response.gender!;
      _panchayatController.text = response.panchayatCentre!;
      _centreController.text = response.panchayatCentre!;
      _frnNumberController.text = response.frnNumber!;
      _addressController.text = response.address!;
      phone = response.phone!;
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Error in Fetching Values",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
      print(e.toString());
    }
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  Future<void> updatevalues() async {
    var response = await api.update(
        phone: phone,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        panchayatCentre: _panchayatController.text,
        gender: _genderController.text,
        dob: _dobController.text,
        frnNumber: _frnNumberController.text,
        address: _addressController.text);
    if (response) {
      Fluttertoast.showToast(
          msg: "Values updated successfully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
      await profileValues();
    } else {
      Fluttertoast.showToast(
          msg: "Error in Updating Values",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<void> _logout() async {
    final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
    await storage.delete(key: "Token Key");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
            (Route<dynamic> route) => false);
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () async {
              if (_isEditing) {
                await updatevalues();
              }
              _toggleEdit();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                  child: Text(
                    'Profile Screen',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _image == null
                        ? AssetImage('assets/profile_placeholder.png')
                        : FileImage(_image!) as ImageProvider,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  child: Container(
                    height: 500,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                          width: 2, color: const Color(0xFFB9B9B9)),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildTextField(
                            controller: _firstNameController,
                            label: 'First Name',
                            isEnabled: _isEditing,
                          ),
                          const SizedBox(height: 10),
                          buildTextField(
                              controller: _lastNameController,
                              label: 'Last Name',
                              isEnabled: _isEditing),
                          const SizedBox(height: 10),
                          buildTextField(
                              controller: _dobController,
                              label: 'Date of Birth',
                              isEnabled: _isEditing),
                          const SizedBox(height: 10),
                          buildTextField(
                              controller: _genderController,
                              label: 'Gender',
                              isEnabled: _isEditing),
                          const SizedBox(height: 10),
                          buildTextField(
                              controller: _panchayatController,
                              label: 'Panchayat',
                              isEnabled: _isEditing),
                          const SizedBox(height: 10),
                          buildTextField(
                              controller: _centreController,
                              label: 'Centre',
                              isEnabled: _isEditing),
                          const SizedBox(height: 10),
                          buildTextField(
                              controller: _frnNumberController,
                              label: 'FRN Number',
                              isEnabled: _isEditing),
                          const SizedBox(height: 10),
                          buildTextField(
                              controller: _addressController,
                              label: 'Address',
                              isEnabled: _isEditing),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: CustomButton(
                    onPressed: _logout,
                    text: "Logout",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      {required TextEditingController controller,
        required String label,
        required bool isEnabled}) {
    return TextFormField(
      controller: controller,
      enabled: isEnabled,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      onChanged: (value) {
        setState(() {
          controller.text = value;
        });
      },
    );
  }
}
