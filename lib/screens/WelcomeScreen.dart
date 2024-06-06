import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:testing/screens/Register/Register_Screen.dart';
import 'package:testing/screens/Login/Login_Screen.dart';
import 'package:testing/screens/navScreen.dart';
import 'package:testing/widget/CustomButton.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );
  Future<void> _initializeState() async {
    final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
    String? value = await storage.read(key: "Token Key");
    if(value != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavScreen()));
    }
  }
  @override
  void initState() {
    super.initState();
    _initializeState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 175, bottom: 30,left: 35, right: 35),
            child: Column(
              children: [
                const Text(
                  "Welcome to VFGA",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Image.asset(
                    "assets/vfgaLogo.png",
                    height: 175,
                  ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [ 
                    Text(
                      "Powered By Soach", 
                      style: TextStyle(
                        fontSize: 20, 
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: Image.asset('assets/logo_soach.png'),
                    ),
                  ],
                ),
                const SizedBox(height: 175),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: CustomButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context)=>  Register_Screen(),
                      ),
                      );
                    },
                    text: "Get Started",
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context)=>  Login_Screen()
                    ),
                    );
                  },
                  child: Text("If you are already registered click here."),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
