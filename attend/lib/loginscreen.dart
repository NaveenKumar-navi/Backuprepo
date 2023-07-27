import 'package:attend/homescreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController idController = TextEditingController();
  TextEditingController passController = TextEditingController();

  double screenHeight = 0;
  double screenWidth = 0;

  //Color primary = const Color(0xffeef444c);
  LinearGradient primary =LinearGradient(colors: [
    Color(0xff574F8D),
    Color(0xffF24BA0)
  ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );


  late SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    final bool iskeyboardVisible = KeyboardVisibilityProvider.isKeyboardVisible(context);
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          iskeyboardVisible ?  SizedBox(height: screenHeight / 16,): Container(
            height: screenHeight / 3,
            width: screenWidth,
            decoration: BoxDecoration(
              gradient: primary,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(70),
              )
            ),
            child: Center(
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: screenWidth / 5,),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: screenHeight / 15,
              bottom: screenWidth / 20,
            ),
              child: Text(
                "Login",
                style: TextStyle(
                  fontSize: screenWidth / 18,
                  fontFamily: "NextBold",
                ),
              ),
            ),
          Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(
                horizontal: screenWidth / 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 fieldTitle("Employee ID"),
                  customerFiled("Enter your employee Id", idController,false),
                  fieldTitle("Password"),
                  customerFiled("Enter your password", passController,true),
                  GestureDetector(
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      String id = idController.text.trim();
                      String password = passController.text.trim();

                      if(id.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content : Text("Employee empty!"),
                        )) ;
                      } else if(password.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content : Text("Password empty!"),
                        )) ;
                      } else {
                        //QuerySnapshot snap = await FirebaseFirestore.instance
                        //    .collection("Employee").where('id', isEqualTo: id).get();

                       // print(snap.docs[0]['password']);

                        try {
                        //  if(password == snap.docs[0]['password']) {
                          //  print("continue");
                         // sharedPreferences = await SharedPreferences.getInstance();

                         // sharedPreferences.setString('employee', 'id').then((_) {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen())
                            );
                         // });
                          //} else {
                            //  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            //  content : Text("Password is not correct!"),
                           //  )) ;
                          //}
                        } catch(e) {
                          /*String error = "";
                          if(e.toString() == "")
                           {
                             setState(() {
                               error = "Employee id does not exit";
                             });
                           } else {
                            setState(() {
                              error = "Error occurred!";
                            });
                          }
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content : Text(error),
                          )) ;*/
                        }
                      }
                    },
                    child: Container(
                      height: 60,
                      width: screenWidth,
                      margin: EdgeInsets.only(top : screenHeight / 40),
                      decoration: BoxDecoration(
                        gradient: primary,
                        borderRadius: const BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Center(
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                            fontFamily: "NexaBold",
                            fontSize: screenWidth / 26,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
          ),
        ],
      ),
    );
  }

  Widget fieldTitle(String title){
    return Container(
      margin : const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: screenWidth / 20,
          fontFamily: "NextBold",
        ),
      ),
    );
  }

  Widget customerFiled(String hint, TextEditingController controller, bool obscure) {
    return Container(
      width: screenWidth,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(2,2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: screenWidth / 6,

            child: Icon(
              Icons.person,
              color: Colors.black54,
              size: screenWidth / 15,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: screenWidth / 12),
              child: TextFormField(
                controller: controller,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: screenHeight / 35,
                  ),
                  border: InputBorder.none,
                  hintText: hint,
                ),
                maxLines: 1,
                obscureText: obscure,
              ),
            ),
          )
        ],
      ),
    );
  }
}
