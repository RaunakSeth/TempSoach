import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing/ApiManagerClass.dart';

import '../../FarmModel.dart';

class Outstanding extends StatefulWidget {
  const Outstanding({Key? key}) : super(key: key);

  @override
  _OutstandingState createState() => _OutstandingState();
}

class _OutstandingState extends State<Outstanding> {
  FormModel? formModel;
  bool isLoading = true;
  ApiManagerClass api=ApiManagerClass();
  @override
  void initState() {
    super.initState();
    fetchFormData();
  }

  Future<void> fetchFormData() async {
    try {
      formModel = await api.getForm();
    } catch (e) {
      print("Error fetching form data: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: isLoading
            ? CircularProgressIndicator()
            : !(formModel!.isEmpty())
            ? ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return UserListItem(
              name: formModel!.farmer!.firstName ?? 'Unknown',
              imagePath: formModel!.farmer!.imageUrl ?? 'assets/person4.png',
              cropSeason: formModel!.cropType!, // Example value
              status: 'Received', // Example value
              cropType: formModel!.cropType ?? 'Unknown',
              cropAmount: formModel!.quantity?.toString() ?? '0.0',
              expectedQuantity: formModel!.expectedProduction?.toString() ?? '0.0',
              actualQuantity: formModel!.quantity?.toString() ?? '0.0',
              applicationDate: formModel!.farmer!.createdAt?.toString().split(' ')[0] ?? 'Unknown',
              expectedHarvestDate: '15/06/2025', // Example value
              location: formModel!.farmer!.address ?? 'Unknown',
              pricePerUnit: '12', // Example value
              totalUnits: formModel!.quantity?.toString() ?? '0.0',
            );
          },
        )
            : Text('Form not found or not submitted yet',
          style: TextStyle(color: Colors.black,
          fontSize: 17),),
      ),
    );
  }
}
class UserListItem extends StatelessWidget {
  final String name;
  final String imagePath;
  final String cropSeason;
  final String status;
  final String cropType;
  final String cropAmount;
  final String expectedQuantity;
  final String actualQuantity;
  final String applicationDate;
  final String expectedHarvestDate;
  final String location;
  final String pricePerUnit;
  final String totalUnits;

  const UserListItem({
    super.key,
    required this.name,
    required this.imagePath,
    required this.cropSeason,
    required this.status,
    required this.cropType,
    required this.cropAmount,
    required this.expectedQuantity,
    required this.actualQuantity,
    required this.applicationDate,
    required this.expectedHarvestDate,
    required this.location,
    required this.pricePerUnit,
    required this.totalUnits,
  });

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
            color: const Color(0xffF2F4FF),
            border: const Border(
              left: BorderSide(width: 8, color: Color(0xff007517)),
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cropSeason,
                    style: const TextStyle(
                      color: Color(0xff222222),
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    status,
                    style: const TextStyle(
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
                    cropType,
                    style: const TextStyle(
                      color: Color(0xff007517),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    cropAmount,
                    style: const TextStyle(
                      color: Color(0xff007517),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 4,
                color: Color(0xff55B067),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Expected Quant.',
                    style: const TextStyle(
                      color: Color(0xff222222),
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    'Quantity',
                    style: const TextStyle(
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
                    expectedQuantity,
                    style: const TextStyle(
                      color: Color(0xff007517),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    actualQuantity,
                    style: const TextStyle(
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
                    'Application Date',
                    style: const TextStyle(
                      color: Color(0xff222222),
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    'Expected Harvest Date',
                    style: const TextStyle(
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
                    applicationDate,
                    style: const TextStyle(
                      color: Color(0xff007517),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    expectedHarvestDate,
                    style: const TextStyle(
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
                    'Location',
                    style: const TextStyle(
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
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: AutoSizeText(
                        location,
                        maxLines: 2,
                        minFontSize: 5,
                        maxFontSize: 20,
                        style: const TextStyle(
                          color: Color(0xff007517),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 4,
                color: Color(0xff55B067),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Price per unit of VFGA',
                    style: const TextStyle(
                      color: Color(0xff222222),
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    'Total VFGA Units',
                    style: const TextStyle(
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
                    pricePerUnit,
                    style: const TextStyle(
                      color: Color(0xff007517),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    totalUnits,
                    style: const TextStyle(
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