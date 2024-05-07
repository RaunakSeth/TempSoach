import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:testing/screens/WelcomeScreen.dart';
import '../../widget/CustomButton.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _firstNameController = TextEditingController(text: 'John');
  TextEditingController _lastNameController = TextEditingController(text: 'Doe');
  TextEditingController _dobController = TextEditingController(text: '01/01/1990');
  TextEditingController _genderController = TextEditingController(text: 'Male');
  TextEditingController _panchayatController = TextEditingController(text: 'Panchayat Name');
  TextEditingController _centreController = TextEditingController(text: 'Centre Name');
  TextEditingController _frnNumberController = TextEditingController(text: '123456789');
  TextEditingController _addressController = TextEditingController(text: '123 Street, City, Country');

  bool _isEditing = false;

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  Future<void> _logout() async {
    final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
    await storage.delete(key: "Token Key");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
    );
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
            onPressed: _toggleEdit,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
            Form(
              key: _formKey,
              child: Container(
                height: 600,
                width: 350,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(width: 5, color: const Color(0xFFB9B9B9)),
                ),
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _firstNameController,
                        enabled: _isEditing,
                        decoration: InputDecoration(
                          labelText: 'First Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _lastNameController,
                        enabled: _isEditing,
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _dobController,
                        enabled: _isEditing,
                        decoration: InputDecoration(
                          labelText: 'Date of Birth',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _genderController,
                        enabled: _isEditing,
                        decoration: InputDecoration(
                          labelText: 'Gender',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _panchayatController,
                        enabled: _isEditing,
                        decoration: InputDecoration(
                          labelText: 'Panchayat',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _centreController,
                        enabled: _isEditing,
                        decoration: InputDecoration(
                          labelText: 'Centre',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _frnNumberController,
                        enabled: _isEditing,
                        decoration: InputDecoration(
                          labelText: 'FRN Number',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _addressController,
                        enabled: _isEditing,
                        decoration: InputDecoration(
                          labelText: 'Address',
                          border: OutlineInputBorder(),
                        ),
                      ),
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
    );
  }
}
