import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiManagerClass {
  String? name;
  String? frnno;

  Future<void> updateprofile(String? value) async {
    try {
      Dio dio = Dio();
      Response response = await dio.get(
        'https://vgfa-backend.onrender.com/api/auth/farmer/me',
        options: Options(headers: {
          "Authorization": "Bearer $value",
        }),
      );
      if (response.data['type'] == "success") {
        name = response.data['data']['user']['first_name'] +
            " " +
            response.data['data']['user']['last_name'];
        frnno = response.data['data']['user']['frn_number'];
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> submitForm({
    required String token,
    required String cropType,
    required double landArea,
    required String landUnit,
    required double expectedProduction,
    required String productionUnit,
    required double issuePercentage,
    required int quantity,
    required String equivalentVFGAUnit,
    required String? phone,
  }) async {
    try {
      // Convert land area and expected production to the appropriate units
      if (landUnit == 'hectares') {
        landArea *= 10000; // Convert hectares to sqm
      } // else it's in acres, no conversion needed

      if (productionUnit == 'tons') {
        expectedProduction *= 1000; // Convert tons to kg
      } // else it's in kg, no conversion needed

      Dio dio = Dio();
      Response response = await dio.post(
        'http://localhost:3000/api/forms/create',
        data: {
          'cropType': cropType,
          'landArea': landArea.toInt(), // Convert to int
          'expextedProduction': expectedProduction.toInt(), // Convert to int
          'issuePercent': issuePercentage.toInt(), // Convert to int
          'quantity': quantity,
          'vgfaUnitEq': equivalentVFGAUnit,
          'farmer': phone,
        },
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );
      print(response.data);
      // Handle response
    } catch (e) {
      print(e.toString());
      // Handle error
    }
  }
}
