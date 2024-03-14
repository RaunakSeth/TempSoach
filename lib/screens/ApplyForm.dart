import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:testing/screens/HomeScreen.dart';
import 'package:testing/widget/CustomButton.dart';

class ApplyForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String _cropType = 'Crop A'; // Set a default value for _cropType

  double _landArea = 0.0;
  double _expectedProduction = 0.0;
  double _issuePercentage = 0.0;
  int _quantity = 0;
  String _equivalentVFGAUnit = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Apply here for Listing",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  const CircleAvatar(
                    radius: 48, // Image radius
                    backgroundImage: AssetImage('assets/asset2.gif'),
                  ),
                  SizedBox(height: 20,),
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
                    width: 350,
                    height: 400,
                    decoration: BoxDecoration(
                      color: const Color(0xffF5F5F5),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        width: 4,
                        color: const Color(0xffB9B9B9),
                      ),
                    ),
                    child: const Padding(
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
                          SizedBox(height: 10,),
                          Text(
                            'Date of Birth: 12/02/2000',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xff303030),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            'Gender: Male',
                            style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              color: Color(0xff303030),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            'Phone: 8306344301',
                            style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              color: Color(0xff303030),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            'Email: ashish.kisan@gmail.com',
                            style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            'Address:',
                            style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              color: Color(0xff303030),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            'City: Kanpur',
                            style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              color: Color(0xff303030),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            'State: Uttar Pradesh',
                            style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              color: Color(0xff303030),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10,),
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
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffF5F5F5),
                      border: Border.all(
                        width: 2, // adjust border width as needed
                        color: Colors.grey, // adjust border color as needed
                      ),
                      borderRadius: BorderRadius.circular(12), // adjust border radius as needed
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
                                border: OutlineInputBorder(), // apply border to dropdown
                              ),
                              value: _cropType,
                              onChanged: (String? newValue) {
                                _cropType = newValue!;
                              },
                              items: <String>['Crop A', 'Crop B', 'Crop C', 'Crop D', 'Crop E']
                                  .map<DropdownMenuItem<String>>((String value) {
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
                                      border: OutlineInputBorder(), // apply border to text field
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
                                Container( // Boxed dropdown button for land unit
                                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey), // Border
                                    borderRadius: BorderRadius.circular(8.0), // BorderRadius
                                  ),
                                  child: DropdownButton<String>(
                                    value: 'acres',
                                    onChanged: (String? newValue) {
                                      // Not implemented yet
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
                                      border: OutlineInputBorder(), // apply border to text field
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
                                Container( // Boxed dropdown button for production unit
                                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey), // Border
                                    borderRadius: BorderRadius.circular(8.0), // BorderRadius
                                  ),
                                  child: DropdownButton<String>(
                                    value: 'kg',
                                    onChanged: (String? newValue) {
                                      // Not implemented yet
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
                                border: OutlineInputBorder(), // apply border to text field
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
                                border: OutlineInputBorder(), // apply border to text field
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
                                border: OutlineInputBorder(), // apply border to text field
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter equivalent VFGA unit';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _equivalentVFGAUnit = value!;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),




                  SizedBox(height: 10,),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: CustomButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
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

