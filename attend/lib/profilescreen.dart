import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
/*import 'package:firebase_storage/firebase_storage.dart';*/
import 'dart:io';

import 'model/user.dart';





class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) :super(key:key);

  @override
  _ProfileScreenState  createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double screenHeight = 0;
  double ScreenWidth = 0;

  LinearGradient primary =const LinearGradient(colors: [
    Color(0xff574F8D),
    Color(0xffF24BA0)
  ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  //Color allColor = const Color(0xffeef444c);
  String birth = "Date of Birth";

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  /*void pickUploadProfilePic() async {
    final image = await.ImagePicker().pickImage(
    source: ImageSource.gallery,
    maxHeight:512,
    maxWidth:512,
    imageQuality:90
    );

    Reference ref = FirebaseStorage.instance.ref().child("${user.employeeId.toLowerCase()}_profilepic.jpg");

    await ref.putFile(File(Image(image!.path));

    ref.getDownloardURL().then((value) {

    });
  }
*/
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    ScreenWidth =  MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 80,bottom: 24),
              height: 120,
              width: 120,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: primary,
              ),
              child: Center(
                child: Icon(
                  Icons.person,
                  color:Colors.white,
                  size: 80,
                ),
              ),
            ),
            Align(
                alignment: Alignment.center,
                child: Text("Employee ${User.employeeId}",
                    style: TextStyle(
                      fontFamily: "NexaBold",
                      fontSize: 18,
                    )
                )
            ),
            const SizedBox(height: 24,),
            textField("First Name","First Name",firstNameController),
            textField("Last Name","Last Name",lastNameController),
            const  Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Date of Birth",
                style: const TextStyle(
                  fontFamily: "NexaBold",
                  color: Colors.black87,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime.now(),
                    builder: (context, child){
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            primary: Colors.black54,
                            secondary: Colors.black54,
                            onSecondary: Colors.white,
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              primary: Colors.black54,
                            ),
                          ),
                          textTheme: const TextTheme(
                            headline4: TextStyle(
                              fontFamily: "NexaBold",
                            ),
                            overline: TextStyle(
                              fontFamily: "NexaBold",
                            ),
                            button: TextStyle(
                              fontFamily: "NexaBold",
                            ),
                          ),
                        ) ,
                        child: child!,
                      );
                    }
                ).then((value) {
                  setState((){
                    birth = DateFormat("MM/DD/YYYY").format(value!);
                  });
                });
              },
              child: Container(
                height:kToolbarHeight,
                width: ScreenWidth,
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.only(left: 11),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: Colors.black54,
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child:  Text(
                    birth,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontFamily:"NexaBold",
                      fontSize:16,

                    ),
                  ),
                ),
              ),
            ),
            textField("Address","Address",addressController),
            GestureDetector(
              onTap: () async{
                String firstName = firstNameController.text;
                String lastName = lastNameController.text;
                String birthDate = birth;
                String address = addressController.text;

                if(User.conEdit){
                  if(firstName.isEmpty){
                    showSnackBar("Please Enter Your First Name!");
                  } else if(lastName.isEmpty){
                    showSnackBar("Please Enter Your Last Name!");
                  } else if(birthDate.isEmpty){
                    showSnackBar("Please Enter Your Birth Date!");
                  } else if(address.isEmpty){
                    showSnackBar("Please Enter Your Address!");
                  } else{
                    /*await FirebaseFirestore.instance.collection("Employee").doc(user.id).update(
                    {
                      'firstName': firstName,
                      'lastName' : lastName,
                      'Date of Birth':birthDate,
                      'address':address,
                      'canEdit' :false,
                    }
                  );*/
                  }
                } else {
                  showSnackBar("You Can\'t Edit anymore, Please Contact Support team.");
                }
              },
              child: Container(
                height:kToolbarHeight,
                width: ScreenWidth,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  gradient: primary,
                ),
                child: const Center(
                  child: Text(
                    "SAVE",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily:"NexaBold",
                      fontSize:16,

                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textField(String title , String hint, TextEditingController controller){
    return  Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: "NexaBold",
              color: Colors.black87,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: TextFormField(
            controller: controller,
            cursorColor: Colors.black54,
            maxLines: 1,
            decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                    color: Colors.black54,
                    fontFamily:"NexaBold"
                ),
                enabledBorder:  OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black54,
                  ),
                ),
                focusedBorder:  OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black54,
                    )
                )
            ),
          ),
        ),
      ],
    );
  }

  void showSnackBar(String text){

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          text,
        ),),
    );
  }
}