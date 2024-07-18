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

  Future<void> _checkStatus() async {
    try {
      bool isVerified = await api.checkStatus(); // Assuming this returns a boolean
      if (!isVerified) {
        _showVerificationDialog();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void _showVerificationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Verification Status",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text("Your application is not verified yet."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

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
    double containerWidth = MediaQuery.of(context).size.width * 0.85; // Adjust width relative to screen width
    double containerHeight = MediaQuery.of(context).size.height * 1.5; // Adjust height relative to screen height
    double innerContainerHeight = MediaQuery.of(context).size.height * 0.24; // Adjust height for the inner container
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.08, // Adjust the height as per your requirement
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        flexibleSpace: ClipPath(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.12,
            decoration: const BoxDecoration(
              color: Color(0xFF11AB2F),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 20,),
                    Container(
                      height: 50,
                      width: 50,
                      child: Image.asset('assets/appBarLogo.png'),
                    ),
                    const SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            children:[
                              SizedBox(
                                width: 130,
                                child: AutoSizeText(
                                  name ?? "",
                                  style: TextStyle(color: Colors.white),
                                  maxLines: 1,
                                  maxFontSize: 24,
                                  minFontSize: 20,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const ProfileScreen()),
                                  );
                                },
                                child:  Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ]
                        ),
                        Text(
                          'Frn No: ${frnno ?? ""}', // Check for null
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.25), // Adjusted SizedBox width
                    Icon(Icons.notifications, color: Colors.white, size: MediaQuery.of(context).size.height * 0.03),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.01), // Adjusted SizedBox width
                    Icon(Icons.settings, color: Colors.white, size: MediaQuery.of(context).size.height * 0.03)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10),
              Container(
                height: MediaQuery.of(context).size.height * 0.30, // Adjust height relative to screen height
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: AppDecoration.outlineGreenA.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.20, // Adjust height relative to screen height
                      width: MediaQuery.of(context).size.width * 0.85, // Adjust width relative to screen width
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: AssetImage('assets/dashborad.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.015), // Adjust height relative to screen height
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CustomOutlinedButton(
                            text: "Apply",
                            margin: const EdgeInsets.only(right: 11),
                            onPressed: () {
                              _checkStatus();
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ApplyForm()),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: CustomOutlinedButton2(
                            text: "Status",
                            margin: const EdgeInsets.only(left: 11),
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
              const SizedBox(height: 20),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Container(
                width: MediaQuery.of(context).size.width * 0.90, // Adjust width relative to screen width
                height: MediaQuery.of(context).size.height * 0.20,
                padding: EdgeInsets.all(6),
                decoration: AppDecoration.gradientGreenToGreenE.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder12,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Total Listed Units",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "0",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 56,
                      ),
                    ),
                    Text(
                      "Current Market value = ₹00,000",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Container(
                width: double.infinity,
                child: NewsBox(),
               /* CarouselSlider(
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.3, // Adjust height relative to screen height
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                  ),
                  items: [
                    'assets/frame1.png',
                    'assets/frame2.png',
                    'assets/frame3.png',
                    'assets/frame4.png',
                    'assets/frame5.png',
                    'assets/frame6.png',
                  ].map((item) => Container(
                    child: Center(
                      child: Image.asset(item, fit: BoxFit.cover, width: 1000),
                    ),
                  )).toList(),
                ),                                                                   */
              ),  
            ],
          ),
        ),
      ),
    );
  }
}
