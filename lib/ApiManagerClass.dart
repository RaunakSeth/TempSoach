import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'Farmer.dart';
import 'package:http/http.dart' as http;

class ApiManagerClass {
  Dio dio = Dio();
  var baseUrl = "http://vgfa-env-1.eba-brkixzb4.ap-south-1.elasticbeanstalk.com";
  var headers;
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );
  Future <void> init() async {
    final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
    String? value = await storage.read(key: "Token Key");
    headers = {
      'Authorization':
      'Bearer $value'
    };
  }
  Future<bool> register({
    required String phone,
    required String firstName,
    required String lastName,
    required String panchayatCentre,
    required String gender,
    required String dob,
    required String frnNumber,
    required String address,
    File? profilePicture,
    File? LandOwnership,
    File? CropHarvestRecords,
    File? Certification,
    File? SoilHealthReport,
    File? FarmPhotos
  }) async {
    // Create a temporary map to hold the data
    final Map<String, dynamic> tempData = {
      "phone": phone,
      "first_name": firstName,
      "last_name": lastName,
      "panchayat_centre": panchayatCentre,
      "gender": gender,
      "dob": dob,
      "frn_number": frnNumber,
      "address": address,
    };

    // Conditionally add files to the map if they are not null
    if (profilePicture != null) tempData["profile_picture"] = profilePicture;
    if (LandOwnership != null) tempData["land_ownership"] = LandOwnership;
    if (CropHarvestRecords != null) tempData["crop_harvest_records"] = CropHarvestRecords;
    if (Certification != null) tempData["certification"] = Certification;
    if (SoilHealthReport != null) tempData["soil_health_report"] = SoilHealthReport;
    if (FarmPhotos != null) tempData["farm_photos"] = FarmPhotos;

    // Declare the final data variable with the built map
    final data = json.encode(tempData);
    try {
      await init();
      var response = await dio.post(
        'http://vgfa-env-1.eba-brkixzb4.ap-south-1.elasticbeanstalk.com/api/auth/farmer/register',
        data: data,
      );
      print(json.encode(response.data));
      print(response.statusMessage);
      return true;
    } catch (e) {
      print("Error function register: $e");
      return false;
    }
  }
  Future<bool> login({
    required String phone,
  }) async {
    var data = json.encode({
      "phone": phone,
    });
    try {
      await init();
      var response = await dio.post(
        'http://vgfa-env-1.eba-brkixzb4.ap-south-1.elasticbeanstalk.com/api/auth/farmer/login',
        data: data,
      );
      print(json.encode(response.data));
      print(response.statusMessage);
      return true;
    } catch (e) {
      print("Error function login: $e");
      return false;
    }
  }
  Future<bool> verify({
    required String? phone,
    required String? otp,
  }) async {
    var data = json.encode({
      "phone": phone,
      "otp":otp
    });
    try {
      await init();
      var response = await dio.post(
        'http://vgfa-env-1.eba-brkixzb4.ap-south-1.elasticbeanstalk.com/api/auth/farmer/verify',
        data: data,
      );
      final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
      await storage.write(key: "Token Key", value: response.data['data']['token']);
      print(json.encode(response.data));
      print(response.statusMessage);
      return true;
    } catch (e) {
      print("Error function verify: $e");
      return false;
    }
  }
  Future<Farmer> data() async {
    Farmer farmer = Farmer();
    try {
      await init();
      var response = await dio.get(
        'http://vgfa-env-1.eba-brkixzb4.ap-south-1.elasticbeanstalk.com/api/auth/farmer/me',
        options: Options(
          headers: headers,
        ),
      );
      print(json.encode(response.data));
      var userData = response.data['data']['user'];
      farmer = Farmer(
        id: userData['_id'],
        firstName: userData['first_name'],
        lastName: userData['last_name'],
        phone: userData['phone'],
        dob: userData['dob'],
        panchayatCentre: userData['panchayat_centre'],
        gender: userData['gender'],
        frnNumber: userData['frn_number'],
        role: userData['role'],
        address: userData['address'],
        isAccountVerified: userData['isAccountVerified'],
        approved: userData['approved'],
        createdAt: userData['createdAt'] != null ? DateTime.parse(userData['createdAt']) : null,
        updatedAt: userData['updatedAt'] != null ? DateTime.parse(userData['updatedAt']) : null,
        v: userData['__v'],
        farmPhotos: userData['FarmPhotos'] != null ? List<String>.from(userData['FarmPhotos']) : null,
        tags: userData['tags'] != null ? List<String>.from(userData['tags']) : null,
        imageUrl: userData['imageUrl'],
        certification: userData['Certification'],
        cropHarvestRecords: userData['CropHarvestRecords'],
        landOwnership: userData['LandOwnership'],
        soilHealthReport: userData['SoilHealthReport'],
      );
      print(response.statusMessage);
      print(response.data);
      return farmer;
    } catch (e) {
      print("Error function data: $e");
      return farmer;
    }
  }

  Future<bool> update({
    required String phone,
    required String firstName,
    required String lastName,
    required String panchayatCentre,
    required String gender,
    required String dob,
    required String frnNumber,
    required String address,
    PlatformFile? profilePicture,
    PlatformFile? LandOwnership,
    PlatformFile? CropHarvestRecords,
    PlatformFile? Certification,
    PlatformFile? SoilHealthReport,
    PlatformFile? FarmPhotos,
  }) async {
    var request = http.MultipartRequest(
        'PUT',
        Uri.parse('http://vgfa-env-1.eba-brkixzb4.ap-south-1.elasticbeanstalk.com/api/auth/farmer/update')
    );

    request.fields.addAll({
      'phone': phone,
      'first_name': firstName,
      'last_name': lastName,
      'panchayat_centre': panchayatCentre,
      'gender': gender,
      'dob': dob,
      'frn_number': frnNumber,
      'address': address,
    });
    if (profilePicture != null) {
      request.files.add(await http.MultipartFile.fromPath('profilePicture', profilePicture.path.toString()));
    }
    if (LandOwnership != null) {
      request.files.add(await http.MultipartFile.fromPath('LandOwnership', LandOwnership.path.toString()));
    }
    if (CropHarvestRecords != null) {
      request.files.add(await http.MultipartFile.fromPath('CropHarvestRecords', CropHarvestRecords.path.toString()));
    }
    if (Certification != null) {
      request.files.add(await http.MultipartFile.fromPath('Certification', Certification.path.toString()));
    }
    if (SoilHealthReport != null) {
      request.files.add(await http.MultipartFile.fromPath('SoilHealthReport', SoilHealthReport.path.toString()));
    }
    if (FarmPhotos != null) {
      request.files.add(await http.MultipartFile.fromPath('FarmPhotos', FarmPhotos.path.toString()));

    }

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      print(responseBody);
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }
  Future<int> createForm({
    required String cropType,
    required int landArea,
    required int expectedProduction,
    required int issuePercent,
    required int quantity,
    required int vgfaUnitEq,
    required String? farmer,
  }) async {
    var datas = json.encode({
      "cropType":cropType,
      "landArea":landArea,
      "expextedProduction":expectedProduction,
      "issuePercent":issuePercent,
      "quantity":quantity,
      "vgfaUnitEq":vgfaUnitEq
    });
    try {
      await init();
      var response = await dio.request(
        'http://vgfa-env-1.eba-brkixzb4.ap-south-1.elasticbeanstalk.com/api/forms/create',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: datas,
      );
      print(json.encode(response.data));
      print(response.statusMessage);
      return int.parse(response.statusCode.toString());
    } on DioError catch (error) {
      // Handle error here
      print(error.response?.statusCode);
      return int.parse(error.response!.statusCode.toString());// Check for status code
    }
  }
  Future<List<String>?> status() async {
    try {
      await init();
      var response = await Dio().get(
        'http://vgfa-env-1.eba-brkixzb4.ap-south-1.elasticbeanstalk.com/api/auth/farmer/status',
        options: Options(
          headers: headers,
        ),
      );
      print(json.encode(response.data));

      if (response.data['status']) {
        print(response.statusMessage);
        print(response.data);
        return null; // No missing fields since the farmer is verified
      } else {
        List<String> missingFields = List<String>.from(response.data['missingFields']);
        print("Missing fields: $missingFields");
        return missingFields; // Return the missing fields
      }
    } catch (e) {
      print("Error function status: $e");
      return null;
    }
  }

  Future<bool> checkStatus() async{
    try {
      await init();
      var response = await Dio().get(
        'http://vgfa-env-1.eba-brkixzb4.ap-south-1.elasticbeanstalk.com/api/auth/farmer/status',
        options: Options(
          headers: headers,
        ),
      );
      if (response.data['status']) {
        return true; // No missing fields since the farmer is verified
      } else {
        return false; // Return the missing fields
      }
    } catch (e) {
      print("Error function status: $e");
      return false;
    }
  }
}

