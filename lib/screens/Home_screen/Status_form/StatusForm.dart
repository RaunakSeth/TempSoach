import 'package:flutter/material.dart';
import 'package:testing/screens/Home_screen/Status_form/timeline_tile.dart';
import 'package:testing/widget/CustomButton.dart';
import 'package:testing/ApiManagerClass.dart';

class StatusFrom extends StatefulWidget {
  const StatusFrom({Key? key}) : super(key: key);

  @override
  State<StatusFrom> createState() => _StatusFromState();
}

class _StatusFromState extends State<StatusFrom> {
  int firstIndex = 0;
  int newindex =0;
  String patidarRemark = '';
  ApiManagerClass api = ApiManagerClass();
  List<Status> statuses = [
    Status(name: 'Application Submitted', isCompleted: true),
    Status(name: 'Approved by Pattidar', isCompleted: false),
    Status(name: 'Approved by Gram Panchayat', isCompleted: false),
    Status(name: 'Approved by Govt. Officials', isCompleted: false),
  ];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    int? state = await api.getState();
    // String? remark = await api.getPatidarRemark();
    if (state != null) {
      setState(() {
        firstIndex = state;
        // patidarRemark = remark;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
      body: Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
            Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              height: MediaQuery.of(context).size.height*0.09,
              width: MediaQuery.of(context).size.width*0.7,
              child: Text(
                "Check Application Status",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 28,
                ),
              ),
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              double containerHeight = MediaQuery.of(context).size.height*0.12;
              double containerWidth = constraints.maxWidth;

              if (containerWidth < 400) {
                containerWidth = containerWidth;
              } else if (containerWidth < 800) {
                containerWidth = 300;
              } else {
                containerWidth = 400;
              }

              double tileWidth = containerWidth / statuses.length;

              return Container(
                height: containerHeight,
                width: containerWidth,
                child: Row(
                  children: statuses.map((status) {
                    int index = statuses.indexOf(status);
                    return Container(
                      width: tileWidth,
                      child: StatusTimelineTile(
                        isFirst: index == newindex,
                        isInProgress: index == newindex + 1,
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
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF434343),
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
                      border: Border.all(color: Color(0xFF11AB2F), width: 2),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Text(
                        "No Remarks",
                        style: TextStyle(
                          color: Color(0xFF007517),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
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
                      border: Border.all(color: Color(0xFF11AB2F), width: 2),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Text(
                        "No Remarks",
                        style: TextStyle(
                          color: Color(0xFF007517),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
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
                shape: BoxShape.circle,
                color: Colors.green,
              ),
            ),
            ],
          ),
                SizedBox(
                  height: MediaQuery.of(context).size.height *0.03,
                  width: 350,
                  child: Text(
                    firstIndex == 0
                        ? "You have successfully submitted the application form for listing of your crop production as VFGA unit."
                        : firstIndex == 1
                        ? "Your application is approved by Pattidar."
                    : firstIndex == 2
                        ? "Your application is approved by Gram Panchayat."
                    : firstIndex == 3
                        ? "Your application is under review of government office."
                        : "Application is rejected.",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
                ),
              ],
            ),
          ),
            ],
          ),
        ),
      ),
    );
  }

  void ViewApplication() {
    // Your code for viewing the application
  }
}
