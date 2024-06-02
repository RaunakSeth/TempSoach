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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                'assets/logo_soach.png',
                height: 40, // Adjust the height as necessary
              ),
            ),
          ),
          body:SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        height: 100,
                        width: 300,
                        child: Text("Check Application Status",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 34
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 150,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text("Application Details",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    SizedBox(
                      height: 160,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget> [
                            Text("View your Application",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              width: 360,
                              child: Text("You have successfully submitted the application form for listing of your crop production as VFGA unit.",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10,),
                            CustomButton(text: "View Application", onPressed: ViewApplication),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Divider(
                      color: Colors.green,
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
                      height: 210,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Remarks On Your Application",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text("By Pattidars",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 2,),
                            Container(
                              height: 60,
                              width: 500,
                              decoration: BoxDecoration(
                                  color: Color(0xFFe7f7ea),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.green, width: 2)
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(4),
                                child: Text("No Remarks",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text("By Gram Panchayat",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 2,),
                            Container(
                              height: 60,
                              width: 500,
                              decoration: BoxDecoration(
                                  color: Color(0xFFe7f7ea),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.green, width: 2)
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(4),
                                child: Text("No Remarks",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Divider(
                      color: Colors.green,
                    ),
                    SizedBox(height: 10,),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          Row(
                              children: [
                                Text("Current Status",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black
                                  ),
                                ),
                                SizedBox(width: 5,),
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ]
                          ),
                          SizedBox(height: 5,),
                          SizedBox(height: 30,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Your application is under review of govt. officials.",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.black
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
  void ViewApplication(){
    print("Application will be shown");
  }
}
