import 'package:attend/animation/animation_enum.dart';
import 'package:attend/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/LoginController.dart';
import 'package:get/get.dart';
import 'package:form_field_validator/form_field_validator.dart';
//import '../component/header_widget.dart';
import '../../component/password_text.dart';
import '../../component/theme_helper.dart';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rive/rive.dart' as rive;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //for animation
  rive.Artboard? riveArtboard;

  late rive.RiveAnimationController idle;
  late rive.RiveAnimationController handsUp;
  late rive.RiveAnimationController handsDown;
  late rive.RiveAnimationController lookLeft;
  late rive.RiveAnimationController lookRight;
  late rive.RiveAnimationController success;
  late rive.RiveAnimationController fail;

  final passwordFocusNode = FocusNode();
  bool isLookingRight = false;
  bool isLookingLeft  = false;

  void removeAllAnimations(){
    riveArtboard?.artboard.removeController(idle);
    riveArtboard?.artboard.removeController(handsUp);
    riveArtboard?.artboard.removeController(handsDown);
    riveArtboard?.artboard.removeController(lookLeft);
    riveArtboard?.artboard.removeController(lookRight);
    riveArtboard?.artboard.removeController(success);
    riveArtboard?.artboard.removeController(fail);
    isLookingLeft = false;
    isLookingRight = false;
  }

  void addIdleAnimation(){
    removeAllAnimations();
    riveArtboard?.artboard.addController(idle);
    debugPrint("idle");
  }
  void addHandsUpAnimation(){
    removeAllAnimations();
    riveArtboard?.artboard.addController(handsUp);
    debugPrint("idle");
  }
  void addHandsDownAnimation(){
    removeAllAnimations();
    riveArtboard?.artboard.addController(handsDown);
    debugPrint("idle");
  }
  void addSuccessAnimation(){
    removeAllAnimations();
    riveArtboard?.artboard.addController(success);
    debugPrint("idle");
  }
  void addFailAnimation(){
    removeAllAnimations();
    riveArtboard?.artboard.addController(fail);
    debugPrint("idle");
  }
  void addLookRightAnimation(){
    removeAllAnimations();
    isLookingRight = true;
    riveArtboard?.artboard.addController(lookRight);
    debugPrint("idle");
  }
  void addLookLeftAnimation(){
    removeAllAnimations();
    isLookingLeft = true;
    riveArtboard?.artboard.addController(lookLeft);
    debugPrint("idle");
  }

  void checkForPasswordFocusNodeToChangeAnimationState(){
    passwordFocusNode .addListener(() { 
     if(passwordFocusNode.hasFocus)
     addHandsUpAnimation();
     else if (!passwordFocusNode.hasFocus)
     addHandsDownAnimation();
     
    });
  }

  @override
  void initState() {
    super.initState();
    idle = rive.SimpleAnimation(AnimationEnum.idle.name);
    handsUp = rive.SimpleAnimation(AnimationEnum.hands_up.name);
    handsDown = rive.SimpleAnimation(AnimationEnum.hands_down.name);
    lookLeft = rive.SimpleAnimation(AnimationEnum.Look_down_left.name);
    lookRight = rive.SimpleAnimation(AnimationEnum.Look_down_right.name);
    success = rive.SimpleAnimation(AnimationEnum.success.name);
    fail = rive.SimpleAnimation(AnimationEnum.fail.name);

    rootBundle.load('assets/login_screen_character.riv').then((data) async {
    final file = rive.RiveFile.import(data);
    final artboard = file.mainArtboard;

    artboard.addController(idle);
    setState(() {
      riveArtboard = artboard;
    });
  
    });

    checkForPasswordFocusNodeToChangeAnimationState();
  }



  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final double _headerHeight = 250;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  double screenHeight = 0;
  double screenWidth = 0;

  LoginController loginController = Get.put(LoginController());

  //Color primary = const Color(0xffeef444c);
  LinearGradient primary = const LinearGradient(
    colors: [Color(0xff574F8D), Color(0xffF24BA0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  late SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    // final bool iskeyboardVisible =
    //     KeyboardVisibilityProvider.isKeyboardVisible(context);
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
      child :Column(
        children: [
           Container(
                  height: screenHeight / 3,
                  width: screenWidth,
                  decoration: BoxDecoration(
                      gradient: primary,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(70),
                        bottomLeft: Radius.circular(70),
                      )),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      SizedBox(
                         height: MediaQuery.of(context).size.height/5,
                         child: riveArtboard != null?
                      rive.Rive(
                        artboard: riveArtboard!,
                        useArtboardSize: false,
                      ) :Container(),
                      ),
                    ],
                  ),
                ),
          Container(
            margin: EdgeInsets.only(
              top: screenHeight / 40,
              bottom: screenWidth / 50,
            ),
           
            child: Text(
              "LOGIN",
              style: TextStyle(
                fontSize: screenWidth / 18,
                fontFamily: "NextBold",
              ),
            ),
          ),
          // Container(
          //     alignment: Alignment.centerLeft,
          //     margin: EdgeInsets.symmetric(
          //       horizontal: screenWidth / 12,
          //     ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    bottom: 24,
                  ),
                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                  child: TextFormField(
                    controller: loginController.emailController,
                    validator: RequiredValidator(errorText: "* Required"),
                    onChanged: (value){
                      if(value.isNotEmpty && value.length < 16 && !isLookingLeft)
                      addLookLeftAnimation();
                      else if (value.isNotEmpty && value.length > 16 && !isLookingRight)
                      addLookRightAnimation();
                    },
                    decoration: ThemeHelper().textInputDecoration(
                        'User Name', 'Enter your user name'),
                  ),
                ),
                const SizedBox(height: 30.0),
                Container(
                  margin: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    bottom: 24,
                  ),
                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                  child: PasswordText(focusNode: passwordFocusNode),                  
                ),
                const SizedBox(height: 30.0),
                Container(
                    child: ElevatedButton(
                  style: ThemeHelper().buttonStyle(),
                  onPressed: isLoading
                      ? null
                      : () {
                        passwordFocusNode.unfocus();
                          if (_formKey.currentState!.validate()) {
                            Future.delayed(const Duration(seconds: 1),(){
                                  addSuccessAnimation();
                            });
                            setState(() {
                              isLoading = true;
                            });
                            loginController.loginWithEmail().then((_) {
                              setState(() {
                                isLoading = false;
                              });
                            }).catchError((error) {
                              setState(() {
                                isLoading = false;
                              });
                              // Show error message
                              Get.snackbar(
                                'Error',
                                'Failed to sign in. Please try again.',
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                              Future.delayed(const Duration(seconds: 1),(){
                                  addFailAnimation();
                            });
                              
                            });
                          }
                        },
                  child: Container(
                    height: 60,
                    width: screenWidth,
                    //margin: EdgeInsets.only(top: screenHeight / 60),
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
                )),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }

  Widget fieldTitle(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: screenWidth / 20,
          fontFamily: "NextBold",
        ),
      ),
    );
  }

  Widget customerFiled(
      String hint, TextEditingController controller, bool obscure) {
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
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: screenWidth / 6,
            child: Icon(
              Icons.person,
              color: Colors.black54,
              size: screenWidth / 15,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: screenWidth / 12),
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
