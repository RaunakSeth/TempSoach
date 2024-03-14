import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:dio/dio.dart';
import 'package:testing/screens/HomeScreen.dart';
import 'package:testing/widget/CustomButton.dart';

class OtpScreen extends StatefulWidget {
  final  String? phone;
  const OtpScreen({Key? key, @required this.phone}) : super(key: key);


  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  String? otpCode;


  void verifyOtp(BuildContext context) async {

    // Check if otpCode and widget.phone are not null or empty
    if (otpCode == null || widget.phone == null) {
      print("OTP code or phone number is null or empty");
      return;
    }

    try {
      print(widget.phone);
      print(otpCode);

      var dio = Dio();
      Response response = await dio.post(
        'https://vgfa-backend.onrender.com/api/auth/verify',
        data: {
          "phone": widget.phone,
          "otp": otpCode
        },
      );
      print(response.data);

      if (response.statusCode == 201) {
        // Success: Move to RegisterScreen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        // Handle other status codes if needed
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print(e.toString());
      // Handle error
    }
  }

  Future<void> LoginUser(BuildContext context) async {
    try {
      Dio dio = Dio();
      Response response = await dio.post(
        'https://vgfa-backend.onrender.com/api/auth/login',
        data: {"phone": widget.phone,},
      );
      print(response);


      // var responseData = json.decode(response.data);
      print(response.data);// Access 'type' property accordingly
      if (response.data['type']== "success") {
        print("Success");
      } else {
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
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
                    color: Colors.green.shade200,
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
                  "Enter the OTP sent to your phone number",
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
                    onPressed: () => verifyOtp(context),
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
                  onTap: () => LoginUser(context),
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
