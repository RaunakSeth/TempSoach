import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'Farmer.dart';

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
  }) async {
    var data = json.encode({
      "phone": phone,
      "first_name": firstName,
      "last_name": lastName,
      "panchayat_centre": panchayatCentre,
      "gender": gender,
      "dob": dob,
      "frn_number": frnNumber,
      "address": address
    });
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
  Future<Farmer> data() async{
    Farmer farmer=Farmer();
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
      );
      print(response.statusMessage);
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
  }) async {
    var data = json.encode({
      "phone":phone,
      "first_name": firstName,
      "last_name": lastName,
      "panchayat_centre": panchayatCentre,
      "gender": gender,
      "dob": dob,
      "frn_number": frnNumber,
      "address": address
    });
    try {
      await init();
      var response = await dio.put(
        'http://vgfa-env-1.eba-brkixzb4.ap-south-1.elasticbeanstalk.com/api/auth/farmer/update',
        data: data,
        options: Options(
          headers: headers,
        ),
      );
      print(json.encode(response.data));
      print(response.statusMessage);
      return true;
    } catch (e) {
      print("Error function update: $e");
      return false;
    }
  }
  Future<bool> createForm({
    required String cropType,
    required int landArea,
    required int expectedProduction,
    required int issuePercent,
    required int quantity,
    required int vgfaUnitEq,
    required String? farmer,
  }) async {
    var data = json.encode({
      "cropType": cropType,
      "landArea": landArea,
      "expectedProduction": expectedProduction,
      "issuePercent": issuePercent,
      "quantity": quantity,
      "vgfaUnitEq": vgfaUnitEq,
      "farmer": farmer,
    });
    try {
      await init();
      var response = await dio.post(
        'http://vgfa-env-1.eba-brkixzb4.ap-south-1.elasticbeanstalk.com/api/forms/create',
        options: Options(
          headers: headers,
        ),
        data: data,
      );
      print(json.encode(response.data));
      print(response.statusMessage);
      return true;
    } catch (e) {
      print("Error function Api: $e");
      return false;
    }
  }
}
