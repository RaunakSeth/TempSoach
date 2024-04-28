import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:testing/screens/Home_screen/HomeScreen.dart';
import 'package:testing/screens/Home_screen/Status_form/TimeLineTileUI.dart';
import 'package:testing/widget/CustomButton.dart';

class StatusFrom extends StatefulWidget {
  const StatusFrom({Key? key}) : super(key: key);

  @override
  State<StatusFrom> createState() => _StatusFromState();
}

class _StatusFromState extends State<StatusFrom> {
  bool isContainer1Visible = false;
  bool isContainer2Visible = false;
  bool isContainer3Visible = false;
  bool isContainer4Visible = false;
  bool isContainer5Visible = false;
  String description = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        actions: [
          IconButton(
            icon: Image.asset("assets/vector.png",
              height: 28,
              width: 28,), // Add your icon here
            onPressed: () {
              // Add your onPressed logic here
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: Column(

          children:[
            Container(
              height: 40,
              child: const Text('Check Application Satus',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              height: 600,
              decoration: BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(width: 5, color: Color(0xFFB9B9B9))
              ),
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20, bottom: 20),
              child: ListView(
                children: [

                  _buildTimelineTile(
                    isFirst: true,
                    isLast: false,
                    isPast: true,
                    text: 'Application Submitted',
                    description: 'You have successfully submitted the application form for listing of your crop production as VFGA unit.',
                    isVisible: isContainer1Visible,
                    onTap: () {
                      setState(() {
                        isContainer1Visible = !isContainer1Visible;
                      });
                    },
                  ),
                  _buildTimelineTile(
                    isFirst: false,
                    isLast: false,
                    isPast: true,
                    text: 'Approved by member of pool of farmers',
                    description: 'Your application is approved by member of pool of farmers.    View remarks on your application.',
                    isVisible: isContainer2Visible,
                    onTap: () {
                      setState(() {
                        isContainer2Visible = !isContainer2Visible;
                      });
                    },
                  ),
                  _buildTimelineTile(
                    isFirst: false,
                    isLast: false,
                    isPast: true,
                    text: 'Approved by Gram Panchayat',
                    description: 'Your application is under review of Gram Panchayat',
                    isVisible: isContainer3Visible,
                    onTap: () {
                      setState(() {
                        isContainer3Visible = !isContainer3Visible;
                      });
                    },
                  ),
                  _buildTimelineTile(
                    isFirst: false,
                    isLast: false,
                    isPast: true,
                    text: 'Approved by Govt. Officials',
                    description: 'Your application is under review of govt. office.',
                    isVisible: isContainer4Visible,
                    onTap: () {
                      setState(() {
                        isContainer4Visible = !isContainer4Visible;
                      });
                    },
                  ),
                  _buildTimelineTile(
                    isFirst: false,
                    isLast: true,
                    isPast: false,
                    text: 'Approved by SEBI',
                    description: 'Application Approved!',
                    isVisible: isContainer5Visible,
                    onTap: () {
                      setState(() {
                        isContainer5Visible = !isContainer5Visible;
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineTile({
    required bool isFirst,
    required bool isLast,
    required bool isPast,
    required String text,
    required String description,
    required bool isVisible,
    required VoidCallback onTap,
  }) {
    return GestureDetector(

      onTap: onTap,
      child: Column(
        children: [
          TimeLineTileUI(
            isFirst: isFirst,
            isLast: isLast,
            isPast: isPast,
            eventChild: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    SizedBox(width: 15.0),
                    Flexible(
                      child: Text(
                        text,
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (isVisible) // Only show container if visibility is true
            Container(
              margin: EdgeInsets.only(left: 60,bottom: 30),
              decoration: BoxDecoration(
                border: Border.all(width: 5, color: Color(0xFFA3A3A3)),
                borderRadius: BorderRadius.circular(15),
                color: Color(0xFFE9ECE9),
              ),
              width: 230,
              height: 230,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Flexible(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('You have successfully submitted the application form for listing of your crop production as VFGA unit.',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                    text: "View Application",
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}