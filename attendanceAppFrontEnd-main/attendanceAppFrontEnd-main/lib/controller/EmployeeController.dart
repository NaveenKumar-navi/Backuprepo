import 'dart:convert';

import 'package:get/get.dart';
import '../Utils/api_end_point.dart';
import '../model/employee.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeController extends GetxController{

Future<dynamic> getEmployeeDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': prefs.getString('token') ?? '',
    };
    try {
      var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.getEmployeeData);
      http.Response response = await http.get(url,headers: headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['status'] == 'Success') {
         return Employee.fromJson(jsonData['data']);
        } else if(jsonData['status'] == 'Error'){
            throw jsonDecode(response.body)['message'];
        }
      }
      throw Exception('No data available');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

}