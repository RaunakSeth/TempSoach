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
            "Authorization":"Bearer $value",
          }));
      print(response.data['message']);
      if (response.data['type']== "success") {
        name=response.data['data']['user']['first_name']+" "+response.data['data']['user']['last_name'];
        frnno=response.data['data']['user']['frn_number'];
      }
    } catch (e) {
      print(e.toString());
    }
  }
}