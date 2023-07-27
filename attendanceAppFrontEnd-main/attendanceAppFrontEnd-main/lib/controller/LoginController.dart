import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:attend/screens/homescreen.dart';

import '../Utils/api_end_point.dart';
import '../model/token.dart';
import '../model/user.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> loginWithEmail() async {
    var headers = {'Content-Type': 'application/json'};
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.loginEmail);
      print(emailController.text.trim());
      print(passwordController.text);
      Map body = {
        'userName': emailController.text.trim(),
        'password': passwordController.text
      };
      http.Response response =
      await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['status'] == 'Success') {
          Users.jwtToken = json['data']['jwt'];
          //Users.username = json['data']['EmployeeName'];
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', Users.jwtToken);
          //await prefs.setString('username',Users.username);
          emailController.clear();
          passwordController.clear();
          print(Users.jwtToken);
          Get.off(const HomeScreen());
        } else if (json['status'] == 'Error') {
          throw jsonDecode(response.body)['message'];
        }
      } else {
        throw jsonDecode(response.body)['message'] ?? "Login Failed";
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
}