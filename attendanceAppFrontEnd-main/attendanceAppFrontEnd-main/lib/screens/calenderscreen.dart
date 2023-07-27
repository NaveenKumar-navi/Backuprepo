//import 'package:attend/model/user.dart';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:attend/MonthPickerDialog.dart';
import 'package:month_year_picker/month_year_picker.dart';
import '../../controller/PunchController.dart';
import '../../model/employee_attendance.dart';
import 'package:get/get.dart';

import '../widget/AttendanceHistoryWidget.dart';

class CalenderScreen extends StatefulWidget {
  CalenderScreen({Key? key}) : super(key: key);

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();


  DateTime selectedMonth = DateTime.now();
  PunchController punchController = Get.put(PunchController());
void refreshAttendanceHistory() async {
    await punchController.getAttendanceList(
      selectedMonth.month.toString(),
      selectedMonth.year.toString(),
    );
  }
  
}

class _CalenderScreenState extends State<CalenderScreen> {
  double screenHeight = 0;
  double screenWidth = 0;

  LinearGradient primary = const LinearGradient(
    colors: [Color(0xff574F8D), Color(0xffF24BA0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  get snap => null;
  DateTime selectedMonth = DateTime.now();
  PunchController punchController = Get.put(PunchController());

// parser for string to date
  DateTime parseDateString(String dateString, String formatString) {
    DateFormat format = DateFormat(formatString);
    return format.parse(dateString);
  }
  // @override
  // void initState() {
  //   super.initState();
  //   _getAttendanceHistory();
  // }
// void _getAttendenceHistory() async {
//     AttendanceHistoryWidget(punchController: punchController);
//   }


  
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    double containerHeight = screenHeight -
        screenHeight / 5 -
        kToolbarHeight -
        50; // Adjust the padding and toolbar height as needed
    List<String> snap = [
      'Date',
      'Check In',
      'Check Out',
    ];

    return Scaffold(
        body: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 30),
            child: Text(
              "My Attendance",
              style: TextStyle(
                fontFamily: "NexaBold",
                fontSize: screenWidth / 18,
              ),
            ),
          ),
          Stack(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 40),
                child: Text(
                  DateFormat('MMM yyyy').format(DateTime.now()),
                  style: const TextStyle(color: Color(0xFFDA4B9D),fontSize: 16,fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(top: 30),
                child: TextButton(
                    onPressed: () async {
                      final selected = await showMonthYearPicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2019),
                        lastDate: DateTime.now(),
                      );
                      //       builder: (BuildContext context, Widget? child) {
                      // return Theme(
                      //     data: ThemeData.light().copyWith(
                      //     dialogBackgroundColor:Color(0xffF24BA0), // Set the dialog's background color to transparent
                      //     ),
                      //     child: Container(
                      //       decoration: const BoxDecoration(
                      //         gradient: LinearGradient(
                      //           colors: [Color(0xff574F8D), Color(0xffF24BA0)],
                      //           begin: Alignment.topLeft,
                      //           end: Alignment.bottomRight,
                      //         ),
                      //       ),
                      //       child: child!,
                      //     ),
                      //   );
                      // };
                      // MonthPickerDialog.showMonthPicker(context);
                    },
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ))),
                    child: const Text(
                      'MONTH',
                      style: TextStyle(color: Color(0xFFDA4B9D),fontWeight: FontWeight.bold),
                    )),
              ),
              Container(
                margin: const EdgeInsets.only(top: 80),
                height: containerHeight,
                child: AttendanceHistoryWidget(punchController: punchController),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
