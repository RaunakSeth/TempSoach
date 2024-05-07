
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
  Future<void> logout() async {
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
              icon: Image.asset(
                "assets/vector.png",
                height: 28,
                width: 28,
              ), // Add your icon here
              onPressed: () {
                // Add your onPressed logic here
              },
            ),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Column(children: [
              const SizedBox(
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
              Container(
                height: 600,
                decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(width: 5, color: const Color(0xFFB9B9B9))),
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 20, bottom: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: CustomButton(
                  onPressed: () => logout(),
                  text: "Logout",
                ),
              ),
            ]
            )
          )

    );
  }
}
