import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:testing/screens/ApplyForm.dart';
import 'package:testing/screens/StatusForm.dart';
import 'package:testing/theme/app_decoration.dart';
import 'package:testing/theme/custom_button_style.dart';
import 'package:testing/theme/custom_text_style.dart';
import 'package:testing/theme/theme_helper.dart';
import 'package:testing/widgets/custom_outlined_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              toolbarHeight: 100,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: ClipPath(
                clipper: Customshape(), // Assuming your custom clipper for the shape
                child: Stack( // Use a Stack to position elements on top of each other
                  children: [
                    Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      color: const Color(0xFF11AB2F),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(50), bottomLeft: Radius.circular(50)),

                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Image(image: AssetImage('assets/iconn.png')),
                              SizedBox(width: 20.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20,),
                                  Text(
                                    'Ashish Kumar',
                                    style: TextStyle(color: Colors.black, fontSize: 25.0),
                                  ),
                                  Text(
                                    'FRN no- 21231234449',
                                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildTwelve(context),
            _buildDashboard(context),
            const SizedBox(height: 20),
            Container(
              height: 130,
              width: 325,// Set the maximum height to 30 logical pixels
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/news.png'),
                  fit: BoxFit.cover, // Adjust the fit of the image as needed
                ),
              ),
            )
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
          const Divider(indent: 5),
          const SizedBox(height: 17),
          const Divider(indent: 5),
          const SizedBox(height: 18),
          const Divider(indent: 5, endIndent: 43),
          const SizedBox(height: 17),
          const Divider(indent: 5),
          const SizedBox(height: 15),
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
                  buttonStyle: CustomButtonStyles.outlineOrangeA,
                  buttonTextStyle: theme.textTheme.titleMedium!,
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
    );
  }

  Widget _buildDashboard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 19),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text(
            "Other Amenities",
            style: theme.textTheme.headlineSmall,
          ),
          const SizedBox(height: 15),
          Container(
            margin: const EdgeInsets.only(right: 2),
            padding: const EdgeInsets.symmetric(horizontal: 95, vertical: 18),
            decoration: AppDecoration.gradientGreenToGreenE.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder12,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 6),
                Container(
                  width: 127,
                  decoration: AppDecoration.outlineBlackF,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "0\n",
                          style: theme.textTheme.displayLarge,
                        ),
                        TextSpan(
                          text: "VFGA Unit",
                          style: CustomTextStyles.headlineSmallInterffffffff,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class Customshape extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();
    path.lineTo(0, height-50);
    path.quadraticBezierTo(width/2, height, width, height-50);
    path.lineTo(width, 0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
