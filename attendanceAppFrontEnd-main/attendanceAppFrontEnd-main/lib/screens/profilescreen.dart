import 'package:attend/model/employee.dart';
import 'package:attend/model/user.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
/*import 'package:firebase_storage/firebase_storage.dart';*/
import 'dart:io';
import 'package:get/get.dart';


import '../controller/EmployeeController.dart';
import '../controller/ImageUploadController.dart';
import '../model/token.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  PickedFile? imageFile;
  final ImagePicker picker = ImagePicker();
  double screenHeight = 0;
  double ScreenWidth = 0;
  String employeeName = "";
  String employeeLoc = "";
  String empEmail = "";
  String empMobile = "";
  String designation = "";

  PickedFile? get pickedFile => null;


  LinearGradient primary = const LinearGradient(
    colors: [Color(0xff574F8D), Color(0xffF24BA0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  //Color allColor = const Color(0xffeef444c);
  String birth = "Date of Birth";

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  EmployeeController employeeController = Get.put(EmployeeController());
  ImageUploadController imageUploadController = Get.put(
      ImageUploadController());

  //Image defaultImage = Image.asset('assets/default_avatar.png');
  Image ?profileImage;

  @override
  void initState() {
    super.initState();
    _getEmployeeData();
  }

  void _getEmployeeData() async {
    try {
      final data = await employeeController.getEmployeeDetails();
      setState(() {
        employeeName = data.firstName;
        employeeLoc = data.address;
        empEmail = data.email;
        empMobile = data.mobileNo;
        designation = data.designation;
      });
    } catch (e) {
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    ScreenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: primary,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                )
            ),
            height: MediaQuery
                .of(context)
                .size
                .height * 0.3,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  // const Stack(
                  //   children: <Widget>[
                  //     Padding(
                  //       padding: EdgeInsets.only(top: 20.0),
                  //     child:CircleAvatar(
                  //       backgroundImage: AssetImage('assets/Image/Photo.jpg'),
                  //       radius: 50,
                  //     ),
                  //     ),
                  //     Positioned(
                  //         bottom: 5,
                  //         right: 10,
                  //         child: CircleAvatar(
                  //           backgroundColor: Colors.white,
                  //           radius: 15,
                  //           child: Icon(Icons.edit
                  //           ),
                  //         )
                  //
                  //     )
                  //   ],
                  // ),
                  imageprofile(),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    employeeName,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    employeeLoc,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Card(
            child: Container(
              child: Column(
                children: <Widget>[
                  Text(
                    "User Information",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      fontFamily: "Lora-VariableFont_wght",
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Location"),
                    subtitle: Text(employeeLoc),
                    leading: Icon(Icons.location_on),
                  ),
                  ListTile(
                    title: const Text("Email"),
                    subtitle: Text(empEmail),
                    leading: const Icon(Icons.email),
                  ),
                  ListTile(
                    title: const Text("MobileNo"),
                    subtitle: Text(empMobile),
                    leading: const Icon(Icons.phone_android),
                  ),
                  ListTile(
                    title: const Text("Designation"),
                    subtitle: Text(designation),
                    leading: const Icon(Icons.person),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget imageprofile() {
    return Center(
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: profileImage?.image == null ? AssetImage(
                  'assets/default_avatar.png') : profileImage?.image,
              // backgroundImage: imageFile == null
              //     ? AssetImage('web/favicon.png')
              //     : FileImage(imageFile),
            ),
          ),
          // Add other widgets to the Stack if needed.
          Positioned(
            bottom: 10,
            right: 15,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: ((builder) => bottomSheet()),
                );
              },
              child: CircleAvatar(
                child: Icon(Icons.camera_alt),
                radius: 10,

              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery
          .of(context)
          .size
          .width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[

          Text(
            "choose profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                icon: Icon(Icons.camera),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                label: Text("Camera"),
              ),

              TextButton.icon(
                icon: Icon(Icons.image),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                label: Text("Gallery"),
              ),
            ],
          )
        ],

      ),
    );
  }


  void takePhoto(ImageSource source) async {
    final pickedFile = await picker.getImage(
      source: source,
    );

    if (pickedFile != null) {
      setState(() {
        imageFile = pickedFile!; // Convert PickedFile to File
      });

      try {
        Image ? image = await imageUploadController.uploadImage(imageFile!); // Pass File to the method
        setState(() {
          profileImage = image;
        });
      } catch (e) {
        // Handle any errors that occurred during image upload
        setState(() {
          profileImage = null; // Set profileImage to null to indicate the error.
        });
      }
    }
  }

}
