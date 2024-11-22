import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:testing/ApiManagerClass.dart';
import 'package:testing/Model/PersonalDetails.dart';
import 'package:testing/Model/bank_details_model.dart';
import 'package:testing/Onboarding_new/new_welcome_screen.dart';
import 'package:testing/Onboarding_new/otp_screen.dart';
import 'package:testing/screens/Home_screen/Status_form/status.dart';

class DocumentUploadPage extends StatefulWidget {
  final PersonalDetails personalDetails;
  final String photoBase64;
  final BankDetailsModel bankDetails;

  const DocumentUploadPage({
    Key? key,
    required this.personalDetails,
    required this.photoBase64,
    required this.bankDetails,
  }) : super(key: key);

  @override
  _DocumentUploadPageState createState() => _DocumentUploadPageState();
}

class _DocumentUploadPageState extends State<DocumentUploadPage> {
  final ApiManagerClass _apiManager = ApiManagerClass();

  // Track uploaded files
  Map<String, PlatformFile?> uploadedFiles = {
    'Address Proof': null,
    'Land Ownership': null,
    'Harvest Record': null,
    'Skill Certificates': null,
    'Farm Photos': null,
  };

  // Ensure the phone number starts with +91
  String getFormattedPhoneNumber(String phone) {
    if (!phone.startsWith('+91')) {
      return '+91${phone.trim()}';
    }
    return phone;
  }

  // File picker function for selecting a file
  Future<void> _pickFile(String fileType, String section) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: fileType == "pdf" ? FileType.custom : FileType.image,
      allowedExtensions: fileType == "pdf" ? ['pdf'] : ['jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      // Check file size
      if (file.size > 25 * 1024 * 1024) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('File exceeds the maximum size of 25 MB.'),
            backgroundColor: Colors.redAccent,
          ),
        );
        return;
      }

      // Update the uploaded file map
      setState(() {
        uploadedFiles[section] = file;
      });
    }
  }

  // Convert Base64 to File
  Future<File> _base64ToFile(String base64Image, String fileName) async {
    final decodedBytes = base64Decode(base64Image);
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');
    return file.writeAsBytes(decodedBytes);
  }

  // Submit function to handle registration and document upload
  // Submit function to handle registration and document upload
  Future<void> _submit() async {
    try {
      // Validate if required files are uploaded
      List<String> missingFiles = [];
      uploadedFiles.forEach((key, value) {
        if (value == null && key != 'Skill Certificates' && key != 'Farm Photos') {
          missingFiles.add(key);
        }
      });

      if (missingFiles.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${missingFiles.join(", ")} not uploaded'),
            backgroundColor: Colors.redAccent,
          ),
        );
        return;
      }

      // Format phone number
      String formattedPhone = getFormattedPhoneNumber(widget.personalDetails.phoneNumber);



      // Convert Base64 photo to File
      File profilePicture = await _base64ToFile(widget.photoBase64, 'profile_picture.jpg');
      print('Bank Details: ${widget.personalDetails.phoneNumber}');

      // Call register API with all data
      bool isRegistered = await _apiManager.register(
        phone: formattedPhone,
        firstName: widget.personalDetails.firstName,
        lastName: widget.personalDetails.lastName,
        panchayat_centre: widget.personalDetails.panchayatName,
        gender: widget.personalDetails.gender,
        dob: widget.personalDetails.dateOfBirth,
        frnNumber: widget.personalDetails.frnNumber,
        address: widget.personalDetails.aadharCardNumber,
        bank_name: widget.bankDetails.bankName,
        account_holder_name: widget.bankDetails.accountHolderName,
        account_number: widget.bankDetails.accountNumber,
        re_enter_account_number: widget.bankDetails.reEnterAccountNumber,
        ifsc_code: widget.bankDetails.ifscCode,
        aadhaar: widget.personalDetails.aadharCardNumber,
        profilePicture: PlatformFile(
          path: profilePicture.path,
          name: 'profile_picture.jpg',
          size: await profilePicture.length(),
        ),
        LandOwnership: uploadedFiles['Land Ownership'],
        CropHarvestRecords: uploadedFiles['Harvest Record'],
        Certification: uploadedFiles['Skill Certificates'],
        SoilHealthReport: uploadedFiles['Address Proof'],
        FarmPhotos: uploadedFiles['Farm Photos'],
      );

      print('Bank Details: ${widget.personalDetails.phoneNumber}');

      if (isRegistered) {
        // Navigate to the next page on success
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpScreen(phoneNumber: formattedPhone),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration failed. Please try again.'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  // Build UI for each section
  Widget _buildUploadContainer(String section, String fileType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          section,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: () => _pickFile(fileType, section),
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade100,
            ),
            child: uploadedFiles[section] != null
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.insert_drive_file, color: Colors.green, size: 40),
                const SizedBox(height: 10),
                Text(
                  uploadedFiles[section]!.name,
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                ),
                const SizedBox(height: 5),
                Text(
                  '${(uploadedFiles[section]!.size / 1024).toStringAsFixed(2)} KB',
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
                ),
              ],
            )
                : Column(
              children: [
                Icon(Icons.cloud_upload_outlined, color: Colors.redAccent, size: 40),
                const SizedBox(height: 10),
                Text(
                  'Click to Upload or drag and drop',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),
                const SizedBox(height: 5),
                Text(
                  '(Max. File size: 25 MB)',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Documents')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ...uploadedFiles.keys.map((section) => _buildUploadContainer(section, 'pdf')).toList(),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}