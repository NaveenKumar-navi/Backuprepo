import 'package:attend/calenderscreen.dart';
import 'package:attend/profilescreen.dart';
import 'package:attend/todayscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'model/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double screenHeight = 0;
  double screenWidth = 0;

  String id = '';

  //Color primary = const Color(0xffeef444c);
  LinearGradient primary =LinearGradient(colors: [
    Color(0xff574F8D),
    Color(0xffF24BA0)
  ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  int currentIndex = 1;

  List<IconData> navigationIcons = [
    FontAwesomeIcons.solidCalendar,
    FontAwesomeIcons.checkCircle,
    FontAwesomeIcons.userCircle,
  ];

  @override
  void initState() {
    super.initState();

    getId();
  }

  void getId() async {
    /*QueryShapshot snap = await FirebaseFirestore.instance
        .collection("Employee")
        .where('id', isEqualTo: User.employeeId)
        .get();

    setState(() {
      User.id = snap.docs[0].id;
    });*/
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    final double size;
    return Scaffold(
      body:IndexedStack(
        index: currentIndex,
        children:  [
          new CalenderScreen(),
          new TodayScreen(),
          new ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        margin: const EdgeInsets.only(
          left: 12,
          right: 12,
          bottom: 24,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for(int i = 0; i < navigationIcons.length; i++)...<Expanded>{
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = i;
                      });
                    },
                    child: Container(
                      height: screenHeight,
                      width: screenWidth,
                      color: Colors.white,
                      child: Center (
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      ShaderMask(
                        shaderCallback: (Rect bounds){
                        return primary.createShader(bounds);},
                          child:Icon(
                            navigationIcons[i],
                            size: i == currentIndex ? 30 : 26,
                            color:Colors.white,
                          ),
                      ),
                          i == currentIndex ? Container(
                            margin: EdgeInsets.only(top: 6),
                            height: 3,
                            width: 22,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(40)),
                              color: Colors.black54,
                              gradient: primary,
                            ),
                          ) : const SizedBox(),
                        ],
                      ),
                  ),
                    ),
                  ),
                ),
              }
            ],
          ),
        ),
      ),
    );
  }
}
