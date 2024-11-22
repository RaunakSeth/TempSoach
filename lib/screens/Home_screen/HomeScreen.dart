import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:testing/screens/Home_screen/ApplyForm.dart';
import 'package:testing/screens/Home_screen/ProfileScreen.dart';
import 'package:testing/screens/Home_screen/Status_form/StatusForm.dart';
import 'package:testing/theme/app_decoration.dart';
import 'package:testing/widgets/customButton2.dart';
import 'package:testing/widgets/custom_outlined_button.dart';
import 'package:testing/widgets/news/news_box.dart';
import 'dart:async';

import '../../ApiManagerClass.dart';
import '../../Farmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? name;
  String? frnno;
  ApiManagerClass api = ApiManagerClass();
  Timer? _timer;

  // @override
  // void initState() {
  //   super.initState();
  //   init();
  //   _startPeriodicStatusCheck();
  // }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void init() async {
    await updateProfile();
  }

  Future<void> updateProfile() async {
    try {
      Farmer list = await api.data();
      setState(() {
        name = "${list.firstName!} ${list.lastName!}";
        frnno = list.frnNumber!;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  // void _startPeriodicStatusCheck() {
  //   _timer = Timer.periodic(Duration(hours: 2, seconds: 0), (timer) {
  //     _checkStatus();
  //   });
  // }

  // Future<void> _checkStatus() async {
  //   try {
  //     bool isVerified = await api.checkStatus(); // Assuming this returns a boolean
  //     if (!isVerified) {
  //       _showVerificationDialog();
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  // void _showVerificationDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(
  //           "Verification Status",
  //           style: TextStyle(
  //             fontSize: 18.0,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         content: Text("Your application is not verified yet."),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text("OK"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: updateProfile(),
      builder: (context, _key) {
        switch (_key.connectionState) {
          case ConnectionState.waiting:
            return Default();
          default:
            return Default();
        }
      },
    );
  }

  Widget Default() {
    double containerWidth = MediaQuery.of(context).size.width;
    double containerHeight = MediaQuery.of(context).size.height * 0.08;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: containerHeight,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        flexibleSpace: Container(
          width: containerWidth,
          decoration: const BoxDecoration(
            color: Color(0xFF11AB2F),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/appBarLogo.png', height: 50, width: 50),
                const SizedBox(width: 10),
                SizedBox(height: 20,),
                Row(
                  children: [
                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          SizedBox(height: containerHeight*0.45,),
                          AutoSizeText(
                            name ?? "",
                            style: const TextStyle(color: Colors.white),
                            maxLines: 1,
                            maxFontSize: 24,
                            minFontSize: 20,
                          ),
                          Text(
                            'Frn No: ${frnno ?? ""}',
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                          ),
                      ]),
                    ),

                  ],
                ),
                // Spacer to create space between left and right items
                Spacer(),
                // Right-aligned items
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ProfileScreen()),
                        );
                      },
                    ),
                    Icon(Icons.notifications, color: Colors.white, size: 24),
                    const SizedBox(width: 8), // Add spacing between icons
                    Icon(Icons.settings, color: Colors.white, size: 24),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: AppDecoration.outlineGreenA.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder12,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: const DecorationImage(
                              image: AssetImage('assets/dashborad.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: CustomOutlinedButton(
                              text: "Apply",
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ApplyForm()),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomOutlinedButton2(
                              text: "Status",
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const StatusFrom()),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                padding: const EdgeInsets.all(6),
                decoration: AppDecoration.gradientGreenToGreenE.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder12,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Total Listed Units",
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "0",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 56),
                    ),
                    Text(
                      "Current Market value = ₹00,000",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              NewsBox(),
            ],
          ),
        ),
      ),
    );
  }
}
