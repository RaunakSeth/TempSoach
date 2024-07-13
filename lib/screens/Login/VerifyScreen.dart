import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';
import 'package:testing/screens/Login/Login_Screen.dart';
import 'package:testing/screens/navScreen.dart';
import 'package:testing/widget/CustomButton.dart';
import '../../ApiManagerClass.dart';



class VerifyScreen extends StatefulWidget {
  final String? phone;
  const VerifyScreen({Key? key, @required this.phone}) : super(key: key);

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  String? otpCode;
  ApiManagerClass api=ApiManagerClass();
  Future<void> verifyOTP(BuildContext context) async {
    try {
      bool response=await api.verify(phone: widget.phone, otp:otpCode);
      if (response) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NavScreen()), // Pass the phone number
        );
      } else {
        Fluttertoast.showToast(
            msg: "Error in Verification",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    } catch (e) {
      print(e.toString()); // Print any errors for debugging
    }
  }
  Future<void> LoginUser(BuildContext context) async {
    try {
      String phone = widget.phone ?? ""; // Default value if widget.phone is null
      bool response = await api.login(phone: phone);
      if (response) {
        Fluttertoast.showToast(
          msg: "Otp is Sent",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Error in Login",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }
  String getMaskedPhoneNumber(String? phone) {
    if (phone == null || phone.length < 4) return phone ?? "";
    return '******' + phone.substring(phone.length - 4);
  }


  @override
  Widget build(BuildContext context) {
    final maskedPhone = getMaskedPhoneNumber(widget.phone);
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
                    onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Login_Screen())),
                    child: const Icon(Icons.arrow_back),
                  ),
                ),
                Image.asset(
                  "assets/asset4.png",
                  height: 200,
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
                Text(
                  "Enter the OTP sent to $maskedPhone",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Flexible(
                  fit: FlexFit.loose,
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
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: CustomButton(
                    text: "Verify",
                    onPressed: () => verifyOTP(context),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
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
                  child:  Text("Resend code.",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade700,
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