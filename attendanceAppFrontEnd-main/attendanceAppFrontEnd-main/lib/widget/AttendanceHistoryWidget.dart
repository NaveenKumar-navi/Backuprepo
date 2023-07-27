import 'package:attend/controller/PunchController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/employee_attendance.dart';

class AttendanceHistoryWidget extends StatelessWidget{

  final PunchController punchController;

   AttendanceHistoryWidget({super.key, required this.punchController});
    double screenHeight = 0;
    double screenWidth = 0;
    
    DateTime selectedMonth = DateTime.now();
  String id = '';

  //Color primary = const Color(0xffeef444c);
  LinearGradient primary =LinearGradient(colors: [
    Color(0xff574F8D),
    Color(0xffF24BA0)
  ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

DateTime parseDateString(String dateString, String formatString) {
    DateFormat format = DateFormat(formatString);
    return format.parse(dateString);
  }
  @override
  Widget build(BuildContext context){
  screenHeight = MediaQuery.of(context).size.height;
  screenWidth = MediaQuery.of(context).size.width;
  return FutureBuilder<List<EmployeeAttendance>>(
      future: punchController.getAttendanceList(
          selectedMonth.month.toString(),
          selectedMonth.year.toString()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('No Data Available'),
          );
        } else {
          final attendanceList = snapshot.data!;
          return ListView.builder(
            itemCount: attendanceList.length,
            itemBuilder: (context, index) {
              final attendance = attendanceList[index];

              return Container(
                margin: EdgeInsets.only(
                    top: index > 0 ? 12 : 0,
                    bottom: 12,
                    left: 8,
                    right: 8),
                height: 100,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(2, 3),
                    )
                  ],
                  borderRadius:
                      BorderRadius.all(Radius.circular(20)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(
                          top: 5, bottom: 5, left: 5, right: 5
                        ),
                        decoration: BoxDecoration(
                          gradient: primary,
                          borderRadius: const BorderRadius.all(
                              Radius.circular(20)),
                        ),
                        child: Center(
                          child: Text(
                            DateFormat('EE dd').format(
                              parseDateString(
                                attendance.date, 'dd/MM/yyyy')),
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Check In",
                            style: TextStyle(
                              fontFamily: 'NexaRegular',
                              fontSize: screenWidth / 22,
                              color: Colors.black54,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            attendance.checkIn,
                            style: TextStyle(
                              fontFamily: 'NexaBold',
                              fontSize: screenWidth / 26,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Check Out",
                            style: TextStyle(
                              fontFamily: 'NexaRegular',
                              fontSize: screenWidth / 22,
                              color: Colors.black54,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            attendance.checkOut,
                            style: TextStyle(
                              fontFamily: 'NexaBold',
                              fontSize: screenWidth / 26,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }

  }
