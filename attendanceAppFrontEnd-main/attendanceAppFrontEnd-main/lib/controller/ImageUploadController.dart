import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attend/Utils/api_end_point.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class ImageUploadController extends GetxController {

  Future<Image?> uploadImage(PickedFile imageFile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': prefs.getString('token') ?? ''
    };
    try {
      var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.uploadImage);
      var request = http.MultipartRequest('POST', url);
      List<int> bytes = await imageFile.readAsBytes();
      Uint8List uint8List = Uint8List.fromList(bytes);
      var multipartFile = http.MultipartFile.fromBytes('file', uint8List, filename: imageFile.path.split('/').last);
      request.files.add(multipartFile);
      request.headers.addAll(headers);
      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = utf8.decode(responseData);
      final json = jsonDecode(responseString);
      if (response.statusCode == 200) {
        if (json['status'] == 'Success') {
          String viewImagUrl = json['data'];
          return getImage(viewImagUrl);
        // return viewImage!= null ?viewImage: ;
        } else if (json['status'] == 'Error') {
          throw jsonDecode(responseString)['message'];
        }
      } else {
        throw "Unknown Error Occured";
      }
    } catch (error) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: const Text('Error'),
              contentPadding: EdgeInsets.all(20),
              children: [Text(error.toString())],
            );
          });
    }
  }

  Future<Image> getImage(String imageUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': prefs.getString('token') ?? '',
    };
    try {
      var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.viewImage + imageUrl);
      http.Response response = await http.get(url,headers: headers);

      if (response.statusCode == 200) {

        if (response.headers['content-type'] == 'image/jpeg' || response.headers['content-type'] == 'image/png' ) {
          // Convert the image bytes to a Flutter Image widget
          return Image.memory(response.bodyBytes);
        }
        // final jsonData = json.decode(response.body);
        // if (jsonData['status'] == 'Success') {
        //   return Employee.fromJson(jsonData['data']);
        // } else if(jsonData['status'] == 'Error'){
        //   throw jsonDecode(response.body)['message'];
        // }
      }
      throw Exception('No data available');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }



}