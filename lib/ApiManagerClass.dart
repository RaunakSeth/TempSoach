import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'Model/FarmModel.dart';
import 'Farmer.dart';
import 'package:http/http.dart' as http;

class ApiManagerClass {
  Dio dio = Dio();
  var baseUrl = "https://vfgabackend.soachglobal.com";
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
    required String panchayat_centre,
    required String gender,
    required String dob,
    required String frnNumber,
    required String address,
    required String bank_name,
    required String account_holder_name,
    required String account_number,
    required String re_enter_account_number,
    required String ifsc_code,
    required String aadhaar,
    PlatformFile? profilePicture,
    PlatformFile? LandOwnership,
    PlatformFile? CropHarvestRecords,
    PlatformFile? Certification,
    PlatformFile? SoilHealthReport,
    PlatformFile? FarmPhotos,
  }) async {
    try {
      await init();

      // Create a multipart request for file upload
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/api/auth/farmer/register'),
      );

      // Add required fields
      request.fields.addAll({
        "phone": phone,
        "first_name": firstName,
        "last_name": lastName,
        "panchayat_centre": panchayat_centre,
        "gender": gender,
        "dob": dob,
        "frn_number": frnNumber,
        "address": address,
        "bank_name": bank_name,
        "account_holder_name": account_holder_name,
        "account_number": account_number,
        "re_enter_account_number": re_enter_account_number,
        "ifsc_code": ifsc_code,
        "aadhaar": aadhaar,
      });

      // Add files if provided
      if (profilePicture != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'profilePicture',
          profilePicture.path.toString(),
        ));
      }
      if (LandOwnership != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'LandOwnership',
          LandOwnership.path.toString(),
        ));
      }
      if (CropHarvestRecords != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'CropHarvestRecords',
          CropHarvestRecords.path.toString(),
        ));
      }
      if (Certification != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'Certification',
          Certification.path.toString(),
        ));
      }
      if (SoilHealthReport != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'SoilHealthReport',
          SoilHealthReport.path.toString(),
        ));
      }
      if (FarmPhotos != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'FarmPhotos',
          FarmPhotos.path.toString(),
        ));
      }

      // Add headers
      request.headers.addAll(headers);

      // Send the request
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        print("Registration Success: $responseBody");
        return true;
      } else {
        print("Registration Failed: ${response.statusCode}, ${response.reasonPhrase}");
        return false;
      }
    } catch (e) {
      print("Error in register: $e");
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
        '$baseUrl/api/auth/farmer/login',
        data: data,
      );
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
        '$baseUrl/api/auth/farmer/verify',
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
        '$baseUrl/api/auth/farmer/me',
        options: Options(
          headers: headers,
        ),
      );
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
    required String panchayat_centre,
    required String gender,
    required String dob,
    required String frnNumber,
    required String address,
    String? aadhaar,
    String? bank_name,
    String? account_holder_name,
    String? account_number,
    String? re_enter_account_number,
    String? ifsc_code,
    PlatformFile? profilePicture,
    PlatformFile? LandOwnership,
    PlatformFile? CropHarvestRecords,
    PlatformFile? Certification,
    PlatformFile? SoilHealthReport,
    PlatformFile? FarmPhotos,
  }) async {
    var request = http.MultipartRequest(
      'PUT',
      Uri.parse('$baseUrl/api/auth/farmer/update'),
    );

    // Add required fields
    request.fields.addAll({
      "phone": phone,
      "first_name": firstName,
      "last_name": lastName,
      "panchayat_centre": panchayat_centre,
      "gender": gender,
      "dob": dob,
      "frn_number": frnNumber,
      "address": address,
    });

    // Add optional bank details if provided
    if (aadhaar != null) {
      request.fields["bank_name"] = aadhaar;
    }
    if (bank_name != null) {
      request.fields["bank_name"] = bank_name;
    }
    if (account_holder_name != null) {
      request.fields["account_holder_name"] = account_holder_name;
    }
    if (account_number != null) {
      request.fields["account_number"] = account_number;
    }
    if (re_enter_account_number != null) {
      request.fields["re_enter_account_number"] = re_enter_account_number;
    }
    if (ifsc_code != null) {
      request.fields["ifsc_code"] = ifsc_code;
    }

    // Add files if provided
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
  Future<FormModel> getForm() async {
    FormModel formModel;
    try {
      await init();
      var response = await dio.get(
        '$baseUrl/api/forms',
        options: Options(
          headers: headers,
        ),
      );
      var formData = response.data['form'];
      formModel = FormModel.fromJson(formData);
      return formModel;
    } catch (e) {
      print("Error in getForm function: $e");
      return FormModel(); // Return an empty FormModel in case of error
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
        '$baseUrl/api/forms/create',
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
        '$baseUrl/api/auth/farmer/status',
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
        '$baseUrl/api/auth/farmer/status',
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
  Future<List<Farmer>> getFarmers() async {
    List<Farmer> farmersList = [];
    try {
      await init();
      var response = await dio.get(
        '$baseUrl/api/community/',
        options: Options(
          headers: headers,
        ),
      );

      var farmersData = response.data['farmers'] as List;

      farmersList = farmersData.map((farmerData) {
        return Farmer.fromJson(farmerData as Map<String, dynamic>);
      }).toList();

      return farmersList;
    } catch (e) {
      print("Error fetching farmers: $e");
      return farmersList;
    }
  }

  Future<int?> getState() async {
    try {
      await init();
      var response = await dio.get(
        '$baseUrl/api/forms',
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        var state = response.data['form']['state'];
        return state;
      } else {
        print('Failed to fetch state: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching state: $e');
      return null;
    }
  }

}
class NewsService {
  final String apiKey = '2164a41ccbb442088be114f985884431';
  final String apiUrl =
      'https://newsapi.org/v2';

  Future<List<dynamic>> fetchNews() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/everything?q=farmers%20india&sortBy=publishedAt&apiKey=$apiKey'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['articles'];
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception('Failed to load news');
    }
  }
}