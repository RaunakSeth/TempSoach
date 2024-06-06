import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:testing/ApiManagerClass.dart';
import 'package:testing/Farmer.dart';// Assuming the file is named

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  late Future<List<Farmer>> _farmersFuture;
  ApiManagerClass api = ApiManagerClass();

  @override
  void initState() {
    super.initState();
    _fetchFarmersData();
  }

  Future<void> _fetchFarmersData() async {
    setState(() {
      _farmersFuture = api.getFarmers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.10,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        flexibleSpace: ClipPath(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.14,
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
                  SizedBox(height: 15,),
                  Padding(
                    padding: EdgeInsets.only(top: 28, left: 16, right: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AutoSizeText(
                          "Community",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          maxLines: 1,
                          minFontSize: 40,
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
      body: Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Members',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF797C7B),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Farmer>>(
                future: _farmersFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No farmers found.'));
                  } else {
                    final farmers = snapshot.data!;
                    return ListView.builder(
                      itemCount: farmers.length,
                      itemBuilder: (BuildContext context, int index) {
                        final farmer = farmers[index];
                        return UserListItem(
                          name: '${farmer.firstName} ${farmer.lastName}',
                          imageUrl: farmer.imageUrl,
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserListItem extends StatelessWidget {
  final String name;
  final String? imageUrl;

  const UserListItem({Key? key, required this.name, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          children: [
            if (imageUrl != null)
              Image.network(
                imageUrl != null
                    ? "http://vgfa-env-1.eba-brkixzb4.ap-south-1.elasticbeanstalk.com$imageUrl"
                    : "https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg",
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return const CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 25,
                  );
                },
              ),
            if (imageUrl == null)
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 24.0,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 36.0,
                ),
              ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//   body: FutureBuilder<List<Farmer>>( // Changed to FarmerList
//     future: _farmersFuture,
//     builder: (context, snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return Center(child: CircularProgressIndicator());
//       } else if (snapshot.hasError) {
//         return Center(child: Text('Error: ${snapshot.error}'));
//       } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//         return Center(child: Text('No farmers found.'));
//       } else {
//         List<Farmer> farmers = snapshot.data!;
//         return ListView.builder(
//           itemCount: farmers.length,
//           itemBuilder: (context, index) {
//             Farmer farmer = farmers;
//             return UserListItem(
//               name: '${farmer.firstName} ${farmer.lastName}',
//               imageUrl: farmer.imageUrl, // Use 'imageUrl' from farmer object
//             );
//           },
//         );
//       }
//     },
//   )
// );
//   }
// }
//
// class UserListItem extends StatelessWidget {
//   final String name;
//   final String? imageUrl; // URL to the farmer's image
//
//   const UserListItem({Key? key, required this.name, this.imageUrl});
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       contentPadding: EdgeInsets.zero,
//       title: Container(
//         padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.black), // Border color
//           borderRadius: BorderRadius.circular(16.0), // Border radius
//         ),
//         child: Row(
//           children: [
//             if (imageUrl != null) // Conditionally display the image
//               CircleAvatar(
//                 backgroundImage: NetworkImage(imageUrl!), // Use NetworkImage for URL
//                 backgroundColor: Colors.transparent, // Transparent for AssetImage
//                 radius: 24.0, // Adjust as needed
//               ),
//             if (imageUrl == null) // Conditionally display default people icon
//               CircleAvatar(
//                 backgroundColor: Colors.grey, // Placeholder color
//                 radius: 24.0, // Adjust as needed
//                 child: Icon(
//                   Icons.person,
//                   color: Colors.white, // Icon color
//                   size: 36.0, // Icon size
//                 ),
//               ),
//             const SizedBox(width: 16.0), // Space between avatar and name
//             Expanded(
//               child: Text(
//                 name,
//                 style: const TextStyle(
//                   fontSize: 24.0,
//                   fontWeight: FontWeight.bold,
//                 ), // Adjust as needed
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }