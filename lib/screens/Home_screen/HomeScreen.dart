import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:testing/screens/Home_screen/ApplyForm.dart';
import 'package:testing/screens/Home_screen/ProfileScreen.dart';
import 'package:testing/screens/Home_screen/Status_form/StatusForm.dart';
import 'package:testing/theme/app_decoration.dart';
import 'package:testing/widgets/custom_outlined_button.dart';

class HomeScreen extends StatefulWidget {
  final String? name;
  final String? frnno;
  final String? phone;
  final String? token; // Add token here
  const HomeScreen(
      {Key? key,
        @required this.name,
        @required this.frnno,
        @required this.phone,
        @required this.token})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String _token; // Initialize token

  @override
  void initState() {
    super.initState();
    _initializeState();
  }

  Future<void> _initializeState() async {
    final storage = FlutterSecureStorage();
    String? token = await storage.read(key: "Token Key");
    if (token != null) {
      setState(() {
        _token = token;
      });
    }
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
                      widget.name ?? "", // Check for null
                      style: const TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    Text(
                      'Frn No:${widget.frnno ?? ""}', // Check for null
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
                const SizedBox(width: 35,),
                const Icon(Icons.notifications, color: Colors.white,),
                const SizedBox(width: 5,),
                const Icon(Icons.settings, color: Colors.white,)
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                children:[
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
                      MaterialPageRoute(builder: (context) => ApplyForm(phone: widget.phone ?? "", token: widget.token ?? "", name: widget.name ?? "", frnno: widget.frnno ?? "",)),
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