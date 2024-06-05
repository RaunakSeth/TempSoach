import 'package:flutter/material.dart';
import 'package:testing/screens/Home_screen/Status_form/timeline_tile.dart';
import 'package:testing/widget/CustomButton.dart';
import 'package:testing/ApiManagerClass.dart';

import '../../../widgets/FarmerStatusCheck.dart';
import '../../navScreen.dart';

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
  ApiManagerClass api = ApiManagerClass();

  @override
  void initState() {
    super.initState();
    checkMissingFieldsOnLoad();
  }

  Future<void> checkMissingFieldsOnLoad() async {
    List<String>? missingFields = await api.status();
    if (missingFields != null && missingFields.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return FarmerStatusCheck(
              missingFields: missingFields,
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => NavScreen()),
                      (Route<dynamic> route) => false,
                );// Navigate back to previous screen
              },
            );
          },
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Status> statuses = [
      Status(name: 'Application Submitted', isCompleted: true),
      Status(name: 'Approved by Pattidar', isCompleted: false),
      Status(name: 'Approved by Gram Panchayat', isCompleted: false),
      Status(name: 'Approved by Govt. Officials', isCompleted: false),
    ];
    int firstIndex = 0; // This can be dynamically set based on your logic

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Image.asset(
                'assets/logo_soach.png',
                height: 40,
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      height: 90,
                      width: 300,
                      child: Text(
                        "Check Application Status",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 34,
                        ),
                      ),
                    ),
                  ),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      double containerHeight = 150; // Default height
                      double containerWidth = constraints.maxWidth;

                      // Adjust the width based on screen size
                      if (containerWidth < 400) {
                        containerWidth = containerWidth; // For small screens
                      } else if (containerWidth < 800) {
                        containerWidth = 300; // For medium screens
                      } else {
                        containerWidth = 400; // For large screens
                      }

                      double tileWidth = containerWidth / statuses.length;

                      return Container(
                        height: containerHeight, // Adjust the height to fit the tiles
                        width: containerWidth,
                        child: Row(
                          children: statuses.map((status) {
                            int index = statuses.indexOf(status);
                            return Container(
                              width: tileWidth, // Adjust the width to fit within the total width of the container
                              child: StatusTimelineTile(
                                isFirst: index == firstIndex,
                                isInProgress: index == firstIndex + 1,
                                isLast: index == statuses.length - 1,
                                status: status,
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Application Details",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
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
                        children: <Widget>[
                          Text(
                            "View your Application",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            width: 360,
                            child: Text(
                              "You have successfully submitted the application form for listing of your crop production as VFGA unit.",
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
                          Text(
                            "Remarks On Your Application",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 5,),
                          Text(
                            "By Pattidars",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 2,),
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFFe7f7ea),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.green, width: 2),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(4),
                              child: Text(
                                "No Remarks",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5,),
                          Text(
                            "By Gram Panchayat",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 2,),
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFFe7f7ea),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.green, width: 2),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(4),
                              child: Text(
                                "No Remarks",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
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
                            Text(
                              "Current Status",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
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
                          ],
                        ),
                        SizedBox(height: 5,),
                        SizedBox(
                          height: 30,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Your application is under review of govt. officials.",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.black,
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
        ),
      ),
    );
  }

  void ViewApplication() {
    print("Application will be shown");
  }
}
