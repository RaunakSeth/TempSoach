import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:testing/ApiManagerClass.dart';
import 'package:testing/widget/CustomButton.dart';

import '../../widgets/FarmerStatusCheck.dart';
import '../navScreen.dart';

class ApplyForm extends StatefulWidget {
  const ApplyForm({Key? key}) : super(key: key);

  @override
  _ApplyFormState createState() => _ApplyFormState();
}

class _ApplyFormState extends State<ApplyForm> {
  final _formKey = GlobalKey<FormState>();
  String _cropType = 'Enter crop'; // Set a default value for _cropType
  String _landUnit = 'acres'; // Default land unit
  String _productionUnit = 'kg'; // Default production unit
  double _landArea = 0.0;
  double _expectedProduction = 0.0;
  double _issuePercentage = 0.0;
  int _quantity = 0;
  int _equivalentVFGAUnit = 0;
  String? phone;
  ApiManagerClass api = ApiManagerClass();

  @override
  void initState() {
    super.initState();
    checkMissingFieldsOnLoad();
  }

  Future<void> checkMissingFieldsOnLoad() async {
    List<String>? missingFields = await api.status();
    if (missingFields != null && missingFields.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return FarmerStatusCheck(
              missingFields: missingFields,
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => NavScreen()),
                      (Route<dynamic> route) => false,
                );
                // Navigate back to previous screen
              },
            );
          },
        );
      });
    }
  }

  Future<void> submitForm() async {
    try {
      // Convert land area and expected production to the appropriate units
      if (_landUnit == 'hectares') {
        _landArea *= 10000; // Convert hectares to sqm
        print("dome");
      } // else it's in acres, no conversion needed
      if (_productionUnit == 'tons') {
        _expectedProduction *= 1000; // Convert tons to kg
        print("dome");
      }
      print("cropType: $_cropType," +
          "landArea: ${_landArea.toInt()}," +
          "expectedProduction: ${_expectedProduction.toInt()}," +
          "issuePercent: ${_issuePercentage.toInt()}," +
          "quantity: ${_quantity.toInt()}," +
          "vgfaUnitEq: ${_equivalentVFGAUnit.toInt()},");
      var list = await api.data();
      phone = list.phone;
      var response = await api.createForm(
        cropType: _cropType,
        landArea: _landArea.toInt(),
        expectedProduction: _expectedProduction.toInt(),
        issuePercent: _issuePercentage.toInt(),
        quantity: _quantity.toInt(),
        vgfaUnitEq: _equivalentVFGAUnit.toInt(),
        farmer: phone,
      );
      if (response >= 200 && response < 300) {
        Fluttertoast.showToast(
          msg: "Successfully submitted apply Form",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else if (response >= 300 && response < 400) {
        // Handle 3xx responses
      } else if (response >= 400 && response < 500) {
        Fluttertoast.showToast(
          msg: "Form Already Exist",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Error in Applying submit",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print(e.toString());
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        flexibleSpace: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Apply here for listing.",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 48,
                    backgroundImage: AssetImage('assets/asset2.gif'),
                  ),
                  SizedBox(height: 20),
                  const Text(
                    "Fill your details here.",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    width: 400,
                    height: 390,
                    decoration: BoxDecoration(
                      color: const Color(0xffF5F5F5),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        width: 4,
                        color: const Color(0xffB9B9B9),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name: Ashish Kumar',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff303030),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Date of Birth: 12/02/2000',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xff303030),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Gender: Male',
                            style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              color: Color(0xff303030),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Phone: ${phone ?? ""}',
                            style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              color: Color(0xff303030),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Email: ashish.kisan@gmail.com',
                            style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Address:',
                            style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              color: Color(0xff303030),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'City: Kanpur',
                            style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              color: Color(0xff303030),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'State: Uttar Pradesh',
                            style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              color: Color(0xff303030),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Postal code: 201206',
                            style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              color: Color(0xff303030),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    width: 400,
                    height: 580,
                    decoration: BoxDecoration(
                      color: const Color(0xffF5F5F5),
                      border: Border.all(
                        width: 2,
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                hintText: 'Select Crop Type',
                                border: OutlineInputBorder(),
                              ),
                              value: _cropType,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _cropType = newValue!;
                                });
                              },
                              items: <String>[
                                'Enter crop', // This should be unique and match the default value
                                'Rice',
                                'Maize',
                                'Wheat',
                                'Jawar',
                                'Bajra'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: 'Enter Land Area',
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter a land area';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _landArea = double.parse(value!);
                                    },
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: DropdownButton<String>(
                                    value: _landUnit,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _landUnit = newValue!;
                                      });
                                    },
                                    items: <String>['acres', 'hectares']
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: 'Enter Expected Production',
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter expected production';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _expectedProduction = double.parse(value!);
                                    },
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: DropdownButton<String>(
                                    value: _productionUnit,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _productionUnit = newValue!;
                                      });
                                    },
                                    items: <String>['kg', 'tons']
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Enter Issue Percentage',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter issue percentage';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _issuePercentage = double.parse(value!);
                              },
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Enter Quantity',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter quantity';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _quantity = int.parse(value!);
                              },
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Enter Equivalent VFGA Unit',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter equivalent VFGA unit';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _equivalentVFGAUnit = int.parse(value!);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: CustomButton(
                      onPressed: () async {
                        await submitForm();
                      },
                      text: "SUBMIT",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
