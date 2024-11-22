import 'package:flutter/material.dart';

class SelectBank extends StatefulWidget {
  const SelectBank({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SelectBankState createState() => _SelectBankState();
}

class _SelectBankState extends State<SelectBank> {
  final List<String> popularBanks = [
    'State Bank of India',
    'Canara Bank',
    'Bank of Baroda',
  ];

  final List<String> otherBanks = [
    'Kotak Mahindra Bank',
    'Indian Bank',
    'Icici Bank',
    'Andhra Bank',
    'HDFC Bank',
    'Axis Bank',
    'Punjab National Bank',
    'Union Bank of India',
  ];

  List<String> filteredBanks = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredBanks = popularBanks + otherBanks;
  }

  void filterBanks(String query) {
    final allBanks = popularBanks + otherBanks;
    final filtered = allBanks.where((bank) => bank.toLowerCase().contains(query.toLowerCase())).toList();
    setState(() {
      searchQuery = query;
      filteredBanks = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.green,
        title: const Text('Bank Details',
        style: TextStyle(color: Colors.white,fontSize: 32,fontWeight: FontWeight.w600)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: mediaQuery.size.width * 0.05,
            vertical: mediaQuery.size.height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select your bank',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: mediaQuery.size.height * 0.02),
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search Bank',
                  border: const OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: mediaQuery.size.height * 0.015,
                    horizontal: mediaQuery.size.width * 0.02,
                  ),
                ),
                onChanged: filterBanks,
              ),
              SizedBox(height: mediaQuery.size.height * 0.02),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: filteredBanks.map((bank) => RadioListTile(
                  title: Text(bank),
                  value: bank,
                  groupValue: searchQuery.isEmpty ? null : bank,
                  onChanged: (value) {
                    Navigator.pop(context, value);
                  },
                )).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
