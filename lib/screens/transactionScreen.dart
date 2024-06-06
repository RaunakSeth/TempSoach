import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:testing/screens/Transction_screens/Outstanding.dart';
import 'package:testing/screens/Transction_screens/Payment.dart';
import 'package:testing/screens/Transction_screens/Rejected.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    Payment(),
    Outstanding(),
    Rejected(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.08,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        flexibleSpace: ClipPath(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.12,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: Color(0xFF11AB2F),
            ),
            child: Column(
              children: [
                SizedBox(height: 18,),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(
                        "Transaction history",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        maxLines: 1,
                        minFontSize: 34,
                      ),
                      Icon(
                        Icons.notifications,
                        color: Colors.white,
                        size: MediaQuery.of(context).size.width * 0.07,
                      ),
                    ],
                  ),
                ),
              ]
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          _buildNavigationBar(),
          Expanded(
            child: _screens[_currentIndex],
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavBarItem('Payment', 0),
          _buildNavBarItem('Outstanding', 1),
          _buildNavBarItem('Rejected', 2),
        ],
      ),
    );
  }

  Widget _buildNavBarItem(String label, int index) {
    bool isSelected = index == _currentIndex;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Column(
        children: [
          SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Color(0xFF11AB2F) : Color(0xff44474F),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 5),
          if (isSelected)
            Container(
              height: 6,
              width: 75, // Adjust width as needed
              decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Color(0xFF11AB2F),
              ),// Green color
            ),
        ],
      ),
    );
  }
}