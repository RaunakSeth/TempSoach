import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pinput/pinput.dart';
import 'package:testing/screens/Home_screen/HomeScreen.dart';
import 'package:testing/screens/navScreen.dart';
import 'package:testing/widget/CustomButton.dart';
import 'package:dio/dio.dart';


class VerifyScreen extends StatefulWidget {
  final String? phone;
  const VerifyScreen({Key? key, @required this.phone}) : super(key: key);

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  String? otpCode;
  String? name;
  String? frnno;
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );
  Future<void> updateprofile(String? value) async {
    final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
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
  Future<void> verifyOTP(BuildContext context) async {
    final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
    try {
      Dio dio = Dio();
      Response response = await dio.post(
        'https://vgfa-backend.onrender.com/api/auth/farmer/verify',
        data: {
          "phone": widget.phone,
          "otp": otpCode,
        },
      );
      print(response.data); // For debugging, you can remove this later
      print("Token value"+response.data['data']['token']);
      await storage.write(key: "Token Key", value: response.data['data']['token']);
      // Access 'type' property accordingly
      if (response.data['type'] == "success") {
        // Navigate to the home screen if verification is successful
       await updateprofile(response.data['data']['token']);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NavScreen(name: name,frnno: frnno,)),
        );
      } else {
        // Handle failure cases if necessary
      }
    } catch (e) {
      print(e.toString()); // Print any errors for debugging
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child:Center(
          child: Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.arrow_back),
                  ),
                ),
                Container(
                  width: 200,
                  height: 200,
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green.shade50,
                  ),
                  child: Image.asset(
                    "assets/register.png",
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Verification",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Enter the OTP send to your phone number",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Pinput(
                    length: 6,
                    showCursor: true,
                    defaultPinTheme: PinTheme(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.green.shade200,
                        ),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onCompleted: (value) {
                      setState(() {
                        otpCode = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: CustomButton(
                    text: "Verify",
                    onPressed: () => verifyOTP(context),
                  ),

                ),
                const SizedBox(height: 20),
                const Text(
                  "Didn't receive any code?",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () => verifyOTP(context),
                  child: const Text("Resend code.",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black38,
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

}
