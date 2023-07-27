import 'dart:convert';

import 'package:attend/model/attendance_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attend/Utils/api_end_point.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/employee_attendance.dart';

class PunchController extends GetxController {
  Future<dynamic> fetchAttendanceData(String date,String checkIn,
      String checkOut,String checkInLoc,String checkOutLoc) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': prefs.getString('token') ?? ''
    };
    try {
      var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.punch);
      Map body = {
        'date': date,
        'logInTime': checkIn,
        'logOutTime': checkOut,
        'loginLocation':checkInLoc,
        'logoutLocation' : checkOutLoc
      };
    
      http.Response response =
      await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['status'] == 'Success') {
          return AttendanceData.fromJson(json['data']);
        } else if (json['status'] == 'Error') {
          throw jsonDecode(response.body)['message'];
        }
      } else {
        throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
      }
    } catch (error) {  
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              contentPadding: EdgeInsets.all(20),
              children: [Text(error.toString())],
            );
          });
    }
  }

  Future<dynamic> fetchAttendanceDataByDate(String date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      //'Authorization': prefs.getString('token') ?? ''
      'Authorization': token ?? ''
    };
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.getByDatePunchData);
      Map body = {
        'date': date
      };
      http.Response response = await http.post(url, body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['status'] == 'Success') {
          return AttendanceData.fromJson(json['data']);
        } else if (json['status'] == 'Error') {
          throw jsonDecode(response.body)['message'];
        }
      }else {
        throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
      }
    } catch (error) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              contentPadding: EdgeInsets.all(20),
              children: [Text(error.toString())],
            );
          });
    }
  }
  Future<List<EmployeeAttendance>> getAttendanceList(String month,String year) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': prefs.getString('token') ?? '',
    };
    Map body = {
      'month': month,
      'year' : year
    };
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.getByAttendanceList);
      http.Response response = await http.post(url,body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['data'] != null) {
          var attendanceData = jsonData['data'];

          if (attendanceData is List) {
            return attendanceData
                .map((data) => EmployeeAttendance.fromJson(data))
                .toList();
          } else if (attendanceData is Map) {
            return [EmployeeAttendance.fromJson(attendanceData)];
          }
        }
      }
      throw Exception('No data available');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }


}
