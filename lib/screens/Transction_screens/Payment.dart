import 'package:flutter/material.dart';

class Payment extends StatelessWidget {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child:Text('Payment Not Processed Yet',
            style: TextStyle(color: Colors.black,
                fontSize: 17),),),),
    );
    // Center(
    //   child: Padding(
    //     padding: const EdgeInsets.all(24),
    //     child: ListView.builder(
    //       itemCount: 10,
    //       itemBuilder: (BuildContext context, int index) {
    //         return const UserListItem();
    //       },
    //     ),
    //   ),
    // );
  }
}

class UserListItem extends StatelessWidget {
  const UserListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Container(
        width: 350,
        height: 280,
        decoration: BoxDecoration(
          border: const Border(
            right: BorderSide(width: 2, color: Color(0xff55B067)),
            top: BorderSide(width: 2, color: Color(0xff55B067)),
            bottom: BorderSide(width: 2, color: Color(0xff55B067)),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          width: 335,
          height: 254,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xffF2FFF5),
            border: const Border(
              left: BorderSide(width: 8, color: Color(0xff007517)),
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Kharif",
                    style: TextStyle(
                      color: Color(0xff222222),
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    "Received",
                    style: TextStyle(
                      color: Color(0xff222222),
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rice (Hybrid)",
                    style: TextStyle(
                      color: Color(0xff007517),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "2400.0",
                    style: TextStyle(
                      color: Color(0xff007517),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Divider(
                height: 4,
                color: Color(0xff55B067),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Expected Quant.",
                    style: TextStyle(
                      color: Color(0xff222222),
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    "Quantity",
                    style: TextStyle(
                      color: Color(0xff222222),
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "1200.0",
                    style: TextStyle(
                      color: Color(0xff007517),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "2400.0",
                    style: TextStyle(
                      color: Color(0xff007517),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Application Date",
                    style: TextStyle(
                      color: Color(0xff222222),
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    "Expected Harvest Date",
                    style: TextStyle(
                      color: Color(0xff222222),
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "12/12/2024",
                    style: TextStyle(
                      color: Color(0xff007517),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "2400.0",
                    style: TextStyle(
                      color: Color(0xff007517),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Location",
                    style: TextStyle(
                      color: Color(0xff222222),
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "xyzstuv",
                    style: TextStyle(
                      color: Color(0xff007517),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Divider(
                height: 4,
                color: Color(0xff55B067),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Price per unit of VFGA",
                    style: TextStyle(
                      color: Color(0xff222222),
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    "Total VFGA Units",
                    style: TextStyle(
                      color: Color(0xff222222),
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "12",
                    style: TextStyle(
                      color: Color(0xff007517),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "2400.0",
                    style: TextStyle(
                      color: Color(0xff007517),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
