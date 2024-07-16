import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:testing/ApiManagerClass.dart';
import 'package:testing/Farmer.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.08,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        flexibleSpace: ClipPath(
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: Color(0xFF11AB2F),
            ),
            child: Align(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 15,),
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AutoSizeText(
                            "Community",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
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
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            SizedBox(height: 10,),
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
            CircleAvatar(
              radius: 24.0,
              backgroundImage: imageUrl != null && imageUrl!.isNotEmpty
                  ? NetworkImage(imageUrl!)
                  : const AssetImage('assets/iconn.png') as ImageProvider,
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  color: Color(0xFF000E08),
                  fontSize: 24.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}