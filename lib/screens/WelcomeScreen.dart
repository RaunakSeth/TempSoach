import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:testing/screens/Home_screen/HomeScreen.dart';
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
  String? name;
  String? frnno;

  Future<void> updateprofile() async {
    final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
    String? value = await storage.read(key: "Token Key");
    try {
      Dio dio = Dio();
      Response response = await dio.get(
          'https://vgfa-backend.onrender.com/api/auth/farmer/me',
          options: Options(headers: {
            "Authorization":"Bearer $value",
          }));
      print(response.data['message']);
      if (response.data['type']== "success") {
        name=response.data['data']['user']['first_name']+" "+response.data['data']['user']['last_name'];
        frnno=response.data['data']['user']['frn_number'];
      }
    } catch (e) {
      print(e.toString());
    }
  }
  Future<void> _initializeState() async {
    final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
    String? value = await storage.read(key: "Token Key");
    if(value != null) {
      await updateprofile();
      Navigator.push(context, MaterialPageRoute(builder: (context) => NavScreen(name:name,frnno: frnno)));
    }
  }
  @override
  void initState() {
    super.initState();
    name='Raunak Seth';
    frnno='3543';
    _initializeState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical:  25, horizontal: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center ,
              children: [
                Image.asset(
                  "assets/asset3.gif",
                  height: 300,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Let's get started",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Jai Jawan! Jai Kisaan!",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                //CustomButton
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
                    Navigator.push(context, MaterialPageRoute(
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
