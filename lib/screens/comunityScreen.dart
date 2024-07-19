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
  List<Farmer> _farmers = [];
  List<Farmer> _filteredFarmers = [];
  bool _isSearching = false;
  ApiManagerClass api = ApiManagerClass();
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _farmersFuture = _fetchFarmersData();
    _searchController.addListener(_filterFarmers);
  }

  Future<List<Farmer>> _fetchFarmersData() async {
    List<Farmer> farmers = await api.getFarmers();
    setState(() {
      _farmers = farmers;
      _filteredFarmers = farmers;
    });
    return farmers;
  }

  void _filterFarmers() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredFarmers = _farmers;
      } else {
        _filteredFarmers = _farmers
            .where((farmer) =>
                farmer.firstName?.toLowerCase().contains(query) == true ||
                farmer.lastName?.toLowerCase().contains(query) == true)
            .toList();
      }
    });
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        _filteredFarmers = _farmers;
      }
    });
  }

  void _callFarmer(Farmer farmer) {
    
    print('Calling ${farmer.firstName} ${farmer.lastName}');
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
                  SizedBox(height: 15),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: _isSearching
                          ? [
                              Container(
                                height: 50,
                                width: 320,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),color: Colors.white),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.fromLTRB(12,8,0,8),
                                      child: Icon(Icons.search,color: Colors.black45,size: 24,)),
                                    Container(
                                      width: 220,
                                      padding: EdgeInsets.fromLTRB(2, 10, 6, 2),
                                      child: TextField(
                                        controller: _searchController,
                                        style: TextStyle(color: Colors.black,fontSize: 20),
                                        decoration: InputDecoration(
                                          hintText: 'Enter Name..',
                                          border: InputBorder.none,
                                          hintStyle: TextStyle(color: Colors.green.withOpacity(0.5),fontSize: 20),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      padding: EdgeInsets.all(8),
                                      icon: Icon(Icons.close_rounded, color: Colors.black45,size: 24),
                                      onPressed: _toggleSearch,
                                    ), 
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.notifications_none_outlined, color: Colors.white,size: MediaQuery.of(context).size.width*0.07),
                                onPressed: _toggleSearch,
                              ),
                            ]
                          : [
                              AutoSizeText(
                                "Community",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                                maxLines: 1,
                                minFontSize: 40,
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.search,
                                        color: Colors.white),
                                    onPressed: _toggleSearch,
                                    iconSize: MediaQuery.of(context).size.width * 0.07,
                                  ),
                                  Icon(
                                    Icons.notifications_none_outlined,
                                    color: Colors.white,
                                    size:
                                        MediaQuery.of(context).size.width * 0.07,
                                  ),
                                  SizedBox(width: 10)
                                ],
                              ),
                            ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            SizedBox(height: 10),
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
                    return ListView.builder(
                      itemCount: _filteredFarmers.length + 1, // Adding one more item for the "Group Chat" section
                      itemBuilder: (BuildContext context, int index) {
                        if (index == _filteredFarmers.length) {
                          return Column(
                            children: [
                              SizedBox(height: 20),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Group Chat',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF797C7B),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                decoration: BoxDecoration(color: Color(0xFF11AB2F),
                                borderRadius: BorderRadius.circular(32),
                                 boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.6),
                                      blurRadius: 4,
                                      offset: Offset(1,4), // changes position of shadow
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.fromLTRB(4,0,4,0),
                                margin: EdgeInsets.fromLTRB(12,0,12,0),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Container(
                                    height: MediaQuery.of(context).size.height * 0.12,
                                    child: Row(
                                      children: [
                                        Icon(Icons.chat_rounded,color: Colors.white,size: MediaQuery.of(context).size.width*0.12,),
                                        const SizedBox(width: 20),
                                        Text("Connect with your Members",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600
                                        ))
                                      ],
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF11AB2F),
                                    elevation: 0
                                
                                  ),
                                ),
                              ),
                              const SizedBox(height: 40)
                            ],
                          );
                        } else {
                          final farmer = _filteredFarmers[index];
                          return UserListItem(
                            name: '${farmer.firstName} ${farmer.lastName}',
                            imageUrl: farmer.imageUrl,
                            onCallPressed: () => _callFarmer(farmer),
                          );
                        }
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
  final VoidCallback onCallPressed;

  const UserListItem({
    Key? key,
    required this.name,
    this.imageUrl,
    required this.onCallPressed,
  }) : super(key: key);

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
            IconButton(
              icon: Icon(Icons.call, color: Colors.green),
              onPressed: onCallPressed,
            ),
          ],
        ),
      ),
    );
  }
}
