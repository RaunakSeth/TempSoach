import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:testing/ApiManagerClass.dart';
import 'package:testing/screens/WelcomeScreen.dart';
import 'package:testing/widget/CustomButton.dart';
import 'package:testing/widgets/DocumentUploadView.dart';
import 'package:testing/widgets/TextIconButton.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );
  ApiManagerClass api = ApiManagerClass();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  TextEditingController _firstNameController = TextEditingController(text: '');
  TextEditingController _lastNameController = TextEditingController(text: '');
  TextEditingController _dobController = TextEditingController(text: '');
  TextEditingController _genderController = TextEditingController(text: '');
  TextEditingController _panchayatController = TextEditingController(text: '');
  TextEditingController _centreController = TextEditingController(text: '');
  TextEditingController _frnNumberController = TextEditingController(text: '');
  TextEditingController _addressController = TextEditingController(text: '');
  String phone = "";
  bool _isEditing = false;
  bool _isEditingDoc=false;
  Widget icon=Icon(Icons.upload_file);
  // File? _image;
  // final picker = ImagePicker();
  FilePickerResult? profile;
  FilePickerResult? LandOwnership;
  FilePickerResult? CropHarvestRecords;
  FilePickerResult? Certification;
  FilePickerResult? SoilHealthReport;
  FilePickerResult? FarmPhotos;
  String? profileName=null;
  String? landOwnershipName=null;
  String? cropHarvestRecordsName=null;
  String? certificationName=null;
  String? soilHealthReportName=null;
  String? farmPhotosName=null;
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await profileValues();
  }

  Future<void> profileValues() async {
    try {
      var response = await api.data();
      _firstNameController.text = response.firstName!;
      _lastNameController.text = response.lastName!;
      _dobController.text = response.dob!;
      _genderController.text = response.gender!;
      _panchayatController.text = response.panchayatCentre!;
      _centreController.text = response.panchayatCentre!;
      _frnNumberController.text = response.frnNumber!;
      _addressController.text = response.address!;
      phone = response.phone!;
      setState(() {
        profileName=response.imageUrl!=null?"http://vgfa-env-1.eba-brkixzb4.ap-south-1.elasticbeanstalk.com"+response.imageUrl.toString():null;
        landOwnershipName = response.landOwnership.toString().substring(23);
        cropHarvestRecordsName = response.cropHarvestRecords.toString().substring(23);
        certificationName = response.certification.toString().substring(23);
        soilHealthReportName = response.soilHealthReport.toString().substring(23);
        farmPhotosName = response.farmPhotos?[0].toString().substring(23); // Assigning the first farm photo as an example
        icon=Icon(Icons.check_circle);
      });
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Error in Fetching Values",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
      print(e.toString());
    }
  }
 void _toggleDocumentEdit()
 {
   if(!_isEditingDoc)
     {
       setState(() {
         icon=Icon(Icons.upload_file);
         landOwnershipName = "Upload";
         cropHarvestRecordsName = "Upload";
         certificationName = "Upload";
         soilHealthReportName = "Upload";
         farmPhotosName = "Upload";

       });
     }
     setState(() {
       _isEditingDoc=!_isEditingDoc;
     });

 }
  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }
  Future<void> updatevalues() async {
    var response = await api.update(
        phone: phone,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        panchayatCentre: _panchayatController.text,
        gender: _genderController.text,
        dob: _dobController.text,
        frnNumber: _frnNumberController.text,
        address: _addressController.text,
        );
    if (response) {
      Fluttertoast.showToast(
          msg: "Values updated successfully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
      await profileValues();
    } else {
      Fluttertoast.showToast(
          msg: "Error in Updating Values",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
  Future<void> updatevaluesDoc() async {
    setState(() {
      icon=SpinKitPouringHourGlass(
      color: Colors.green,
      size: 24.0,
      );
    });
    var response = await api.update(
        phone: phone,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        panchayatCentre: _panchayatController.text,
        gender: _genderController.text,
        dob: _dobController.text,
        frnNumber: _frnNumberController.text,
        address: _addressController.text,
        profilePicture:profile?.files.first,
        LandOwnership:LandOwnership?.files.first,
        CropHarvestRecords:CropHarvestRecords?.files.first,
        Certification:Certification?.files.first,
        SoilHealthReport:SoilHealthReport?.files.first,
        FarmPhotos:FarmPhotos?.files.first);
    if (response) {
      setState(() {
        icon=Icon(Icons.check_circle);
        landOwnershipName = "Uploaded";
        cropHarvestRecordsName = "Uploaded";
        certificationName = "Uploaded";
        soilHealthReportName = "Uploaded";
        farmPhotosName = "Uploaded";
      });
      Fluttertoast.showToast(
          msg: "Values updated successfully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
      await profileValues();
    } else {
      Fluttertoast.showToast(
          msg: "Error in Updating Values",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<void> pickfile(String type) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        switch (type) {
          case "Profile":
            profile = result;
            break;
          case "LandOwnership":
            LandOwnership = result;
            break;
          case "CropHarvestRecords":
            CropHarvestRecords = result;
            break;
          case "Certification":
            Certification = result;
            break;
          case "SoilHealthReport":
            SoilHealthReport = result;
            break;
          case "FarmPhotos":
            FarmPhotos = result;
            break;
        }
      });
    } else {
      // User canceled the picker
      Fluttertoast.showToast(
          msg: "No file selected",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<void> _logout() async {
    final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
    await storage.delete(key: "Token Key");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
            (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit_outlined,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () async {
              if (!_isEditing) {
                _toggleEdit();
              }
            },
          ),
          IconButton(
            icon: Icon(
              Icons.cloud_upload,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () async {
              if (!_isEditingDoc) {
                _toggleDocumentEdit();
              }
            },
          ),
          IconButton(
          icon: Icon(
            Icons.logout,
            color: Colors.black,
            size: 30,
          ),
          onPressed: _logout,
        ),

        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                  child: Text(
                    'Profile Screen',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                GestureDetector(
                  onTap: () => _isEditingDoc?pickfile("Profile"):{},
                  child: CachedNetworkImage(
                    imageUrl: profileName!=null?"$profileName":"https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg",
                    placeholder: (context, url) => const CircleAvatar(
                      backgroundColor: Colors.amber,
                      radius: 50,
                    ),
                    imageBuilder: (context, image) => CircleAvatar(
                      backgroundImage: image,
                      radius:50,
                    ),
                  )
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 40,
                  child: Row(
                      children:<Widget> [
                      Padding(padding: const EdgeInsets.all(4),),
                       TextIconButton(
                        text: 'Details',
                        icon: Icon(
                          Icons.description,
                          color: Colors.black,
                          size: 30,
                        ),
                        onPressed: ()=>{}
                        // async {
                        //   if (_isEditing) {
                        //     await updatevalues();
                        //   }
                        //   _toggleEdit();
                        // },
                      )
                      ],
                    ),
                  ),
                  // child: Text(
                  //   'Edit',
                  //   style: TextStyle(
                  //     color: Colors.black,
                  //     fontWeight: FontWeight.normal,
                  //     fontSize: 30,
                  //   )
                  // ),
                Form(
                  key: _formKey,
                  child: Container(
                    // Remove the fixed height to allow the container to adjust to its content
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                          width: 2,
                          color: const Color(0xFFB9B9B9)
                      ),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildTextField(
                          controller: _firstNameController,
                          label: 'First Name',
                          isEnabled: _isEditing,
                        ),
                        const SizedBox(height: 10),
                        buildTextField(
                            controller: _lastNameController,
                            label: 'Last Name',
                            isEnabled: _isEditing
                        ),
                        const SizedBox(height: 10),
                        buildTextField(
                            controller: _dobController,
                            label: 'Date of Birth',
                            isEnabled: _isEditing
                        ),
                        const SizedBox(height: 10),
                        buildTextField(
                            controller: _genderController,
                            label: 'Gender',
                            isEnabled: _isEditing
                        ),
                        const SizedBox(height: 10),
                        buildTextField(
                            controller: _panchayatController,
                            label: 'Panchayat',
                            isEnabled: _isEditing
                        ),
                        const SizedBox(height: 10),
                        buildTextField(
                            controller: _centreController,
                            label: 'Centre',
                            isEnabled: _isEditing
                        ),
                        const SizedBox(height: 10),
                        buildTextField(
                            controller: _frnNumberController,
                            label: 'FRN Number',
                            isEnabled: _isEditing
                        ),
                        const SizedBox(height: 10),
                        buildTextField(
                            controller: _addressController,
                            label: 'Address',
                            isEnabled: _isEditing
                        ),
                        const SizedBox(height: 10),
                        // Add any additional fields here
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 40,
                  child: Row(
                    children:<Widget> [
                      Padding(padding: const EdgeInsets.all(4),),
                        TextIconButton(
                          text: 'Update Documents',
                          icon: Icon(
                            Icons.cloud_upload,
                            color: Colors.black,
                            size: 30,
                          ),
                          onPressed: ()=>{}
                          // async {
                          //   if (_isEditingDoc) {
                          //     await updatevaluesDoc();
                          //   }
                          //   _toggleDocumentEdit();
                          // },
                        ),
                      ]
                  ),
                ),
                Form(
                  key: _formKey1,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // DocumentUploadView(
                        //   title: 'Profile Photo',
                        //   description: '*Please upload your profile photo.',
                        //   onPressed: () => pickfile("ProfilePhoto"),
                        //   buttonText: "Pick Profile Photo",
                        // ),
                        // const SizedBox(height: 10),
                        DocumentUploadView(
                          title: 'Land Ownership',
                          description: '*Land ownership certificate (patta), Land lease agreement, Land records documentation',
                          onPressed: () => _isEditingDoc?pickfile("LandOwnership"):{},
                          icon: icon,
                          buttonText: landOwnershipName == null ? "Upload" : landOwnershipName.toString(),
                        ),
                        const SizedBox(height: 10),
                        DocumentUploadView(
                          title: 'Crop Harvest Records',
                          description: '*Harvest Summary Reports, Crop Yield Records, Production Volume Logs',
                          onPressed: () => _isEditingDoc?pickfile("CropHarvestRecords"):{},
                          icon: icon,
                          buttonText: cropHarvestRecordsName == null ? "Upload" : cropHarvestRecordsName.toString(),
                        ),
                        const SizedBox(height: 10),
                        DocumentUploadView(
                          title: 'Certification',
                          description: '*Organic Certification Documents, Good Agricultural Practices (GAP) Certification, Fair Trade Certification',
                          onPressed: () => _isEditingDoc?pickfile("Certification"):{},
                          icon: icon,
                          buttonText: certificationName == null ? "Upload" : certificationName.toString(),
                        ),
                        const SizedBox(height: 10),
                        DocumentUploadView(
                          title: 'Soil Health Report',
                          description: '*Soil Testing Results, Soil Quality Analysis, Soil Fertility Report',
                          onPressed: () => _isEditingDoc?pickfile("SoilHealthReport"):{},
                          icon: icon,
                          buttonText: soilHealthReportName == null ? "Upload" : soilHealthReportName.toString(),
                        ),
                        const SizedBox(height: 10),
                        DocumentUploadView(
                          title: 'Farm Photos',
                          description: '*Current Crop Photos, Farm Infrastructure Images, Seasonal Progress Photos',
                          onPressed: () => _isEditingDoc?pickfile("FarmPhotos"):{},
                          icon: icon,
                          buttonText: farmPhotosName == null ? "Upload" : farmPhotosName.toString(),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: _isEditing || _isEditingDoc,
                  child: SizedBox(
                    height: 20,
                  ),
                ),
            Visibility(
              visible: _isEditing || _isEditingDoc,
              child:SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: CustomButton(
                    onPressed: () async {
                      if(_isEditing) {
                        await updatevalues();
                        _toggleEdit();
                      }
                      if(_isEditingDoc) {
                        await updatevaluesDoc();
                        _toggleDocumentEdit();
                      }
                    },
                    text: "Save",
                  ),
                ),
              ),
                Visibility(
                  visible: _isEditing || _isEditingDoc,
                  child: SizedBox(
                    height: 20,
                  ),
                ),],

                SizedBox(height: 20,),
              ],

            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    required bool isEnabled,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start (left)
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0), // Adds space between the label and the text field
          child: Text(
            label,
            style: TextStyle(
              color: Colors.grey, // Adjust the color to match the design
              fontSize: 16, // Adjust the font size if needed
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          enabled: isEnabled,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0), // Rounded corners
              borderSide: BorderSide(color: isEnabled ? Colors.green : Colors.grey), // Border color based on isEnabled
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0), // Rounded corners
              borderSide: BorderSide(color: Colors.green), // Border color for enabled state
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0), // Rounded corners
              borderSide: BorderSide(color: Colors.green.shade900), // Border color for focused state
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15), // Adjusts the padding
          ),
          style: TextStyle(color: isEnabled ? Colors.grey : Colors.black), // Text color based on isEnabled
          onChanged: (value) {
            // No need to call setState here, controller.text is automatically updated
          },
        ),
      ],
    );
  }

}
