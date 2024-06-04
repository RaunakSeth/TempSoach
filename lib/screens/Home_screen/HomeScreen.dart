import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:testing/screens/Home_screen/ApplyForm.dart';
import 'package:testing/screens/Home_screen/ProfileScreen.dart';
import 'package:testing/screens/Home_screen/Status_form/StatusForm.dart';
import 'package:testing/theme/app_decoration.dart';
import 'package:testing/widgets/custom_outlined_button.dart';
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

  @override
  void initState() {
    super.initState();
    init();
    _startPeriodicStatusCheck();
  }

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

  void _startPeriodicStatusCheck() {
    _timer = Timer.periodic(Duration(hours: 0,seconds: 120), (timer) {
      _checkStatus();
    });
  }

  Future<void> _checkStatus() async {
    try {
      // Call your API to get the status
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
          title: Text("Verification Status",
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),),
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

  Widget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xff11AB2F),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          color: Color(0xff11AB2F),
        ),
        child: Column(
          children: [
            const SizedBox(height: 40,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 20,),
                const Image(image: AssetImage('assets/iconn.png')),
                const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name ?? "", // Check for null
                      style: const TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    Text(
                      'Frn No:${frnno ?? ""}', // Check for null
                      style: const TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ],
                ),
                const SizedBox(width: 10,),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProfileScreen()),
                      );
                    },
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    )
                ),
                const SizedBox(width: 30,),
                const Icon(Icons.notifications, color: Colors.white,),
                const SizedBox(width: 5,),
                const Icon(Icons.settings, color: Colors.white,)
              ],
            ),
          ],
        ),
      ),
    );
  }  @override
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: _buildAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              clipBehavior: Clip.none,
              children: [
                CustomPaint(
                  size: Size(MediaQuery.of(context).size.width, 250),
                  painter: CurvePainter(),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: SizedBox(
                    height: 440,
                    width: 400,
                    child: Column(
                      children: [
                        const SizedBox(height: 10,),
                        _buildTwelve(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10,),
            const Row(
                children: [
                  SizedBox(width: 20,),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Other Amenities",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ]
            ),
            _totallistedunits(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTwelve(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 22),
      decoration: AppDecoration.outlineGreenA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 150,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CustomOutlinedButton(
                  text: "Apply",
                  margin: const EdgeInsets.only(right: 11),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ApplyForm()),
                    );
                  },
                ),
              ),
              Expanded(
                child: CustomOutlinedButton(
                  text: "Status",
                  margin: const EdgeInsets.only(left: 11),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const StatusFrom())
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _totallistedunits(BuildContext context) {
    return Container(
      height: 450,
      color: Colors.white,
      padding: const EdgeInsets.all(12),
      width: 380,
      child: Column(
        children: [
          const SizedBox(height: 10,),
          Container(
            height: 200,
            width: 380,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  height: 180,
                  width: 360,
                  padding: const EdgeInsets.all(12),
                  decoration: AppDecoration.gradientGreenToGreenE
                      .copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder12),
                  child: const Column(
                    children: [
                      SizedBox(height: 10,),
                      Text("Total Listed Units",
                        style: TextStyle(color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      Text("0",
                        style: TextStyle(color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 56),
                      ),
                      Text("Current Market value = ₹00,000",
                        style: TextStyle(color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 150,
            width: 360,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/news.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20,)
        ],
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color(0xff11AB2F);
    Path path = Path()
      ..lineTo(0, size.height - 140)
      ..quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 140)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
