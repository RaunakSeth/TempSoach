import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:testing/screens/Home_screen/HomeScreen.dart';
import 'package:testing/screens/comunityScreen.dart';
import 'package:testing/screens/transactionScreen.dart';

class NavScreen extends StatefulWidget {
  // Add mobile number parameter
  const NavScreen({Key? key}) : super(key: key);

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _selectedIndex = 0;
  final NotchBottomBarController _controller = NotchBottomBarController();
  late List<Widget> _screens; // Declare _screens

  @override
  void initState() {
    super.initState();
    // Initialize _screens after widget is available
    _screens = [
      CommunityScreen(),
      HomeScreen(),
      TransactionScreen(),
    ];
    _controller.index=1;
    _selectedIndex=1;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AnimatedNotchBottomBar(
        showLabel: true,
        itemLabelStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 8.0,
        ),
        notchBottomBarController: _controller,
        bottomBarItems: [
          BottomBarItem(
              inActiveItem: Lottie.asset('animations/community.json',
                  repeat: false),
              activeItem: Lottie.asset('animations/community.json'),
              itemLabel: 'Community'),
          BottomBarItem(
            inActiveItem: Image.asset(
              "assets/home_ani.gif",
              color: Color(0xFF11AB2F),
            ),
            activeItem: Image.asset(
              "assets/home_ani.gif",
              color: Color(0xFF11AB2F),
            ),
            itemLabel: 'Home',
          ),
          BottomBarItem(
            inActiveItem: Image.asset(
              "assets/wallet.gif",
              color: Color(0xFF11AB2F),
            ),
            activeItem: Image.asset(
              "assets/wallet.gif",
              color: Color(0xFF11AB2F),
            ),
            itemLabel: 'Transaction',
          ),
        ],
        onTap: _onItemTapped,
        kBottomRadius: 10,
        kIconSize: 24,
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
