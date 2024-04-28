import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:testing/screens/Home_screen/HomeScreen.dart';
import 'package:testing/screens/comunityScreen.dart';
import 'package:testing/screens/transactionScreen.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    HomeScreen(),
    CommunityScreen(),
    TransactionScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        buttonBackgroundColor: const Color(0xFF11AB2F),
        color: const Color(0xFF11AB2F),
        animationDuration: const Duration(milliseconds: 400),
        items: const [
          CurvedNavigationBarItem(
            child: Icon(Icons.home),
            label: 'Home',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.people),
            label: 'Community',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.attach_money),
            label: 'Transaction',
          ),
        ],
        onTap: _onItemTapped,
      ),
      body: _screens[_selectedIndex],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: NavScreen(),
  ));
}
