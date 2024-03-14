import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                    child: Container(// Container with padding for better alignment
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0,),
                      child: Row( // Row to arrange search bar and icon horizontally
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space evenly
                        children: [
                          Expanded(//// Expand search bar to fill most of the space
                            child: TextField(
                              decoration: InputDecoration(
                                fillColor: Colors.white, // Fill color for the textbox
                                filled: true, // Enable filling with the fillColor
                                hintText: 'Search',
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0), // Slightly rounded corners
                                ),
                              ),
                              onChanged: (value) {
                                // Handle search query changes here
                              },
                            )

                          ),
                          IconButton( // Bell icon button
                            icon: const Icon(Icons.notifications,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              // Add functionality for bell icon press
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 130, // Adjust position according to AppBar height
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children:[
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Group Admin',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF797C7B),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const UserListItem(name: 'Aman Singh', imagePath: 'assets/person1.png'),
                  const SizedBox(height: 20,),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Member',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF797C7B),
                      ),
                    ),
                  ),
                  Expanded( // Wrap the ListView.builder with Expanded
                    child: ListView.builder(
                      itemCount: 10, // Change this to your desired item count
                      itemBuilder: (BuildContext context, int index) {
                        return const UserListItem(name: 'Ashish Kumar',
                            imagePath: 'assets/person4.png'
                        );
                      },
                    ),
                  ),
                ],
              ),
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

class UserListItem extends StatelessWidget {
  final String name;
  final String imagePath; // Path to the asset image

  const UserListItem({Key? key, required this.name, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black), // Border color
          borderRadius: BorderRadius.circular(16.0), // Border radius
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(imagePath),
              backgroundColor: Colors.transparent, // Transparent for AssetImage
              radius: 24.0, // Adjust as needed
            ),
            const SizedBox(width: 16.0), // Space between avatar and name
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold
                ), // Adjust as needed
              ),
            ),
          ],
        ),
      ),
    );
  }
}



