// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class MonthPickerDialog {
//   static Future<void> showMonthPicker(BuildContext context) async {

//     DateTime? selectedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(DateTime.now().year - 1),
//       lastDate: DateTime(DateTime.now().year + 1),
//       builder: (BuildContext context, Widget? child) {
//         return Theme(
//           data: ThemeData.light().copyWith(
//             primaryColor:const Color(0xffF24BA0), // Customize the color if needed
//             colorScheme: const ColorScheme.light(
//               primary: Color(0xffF24BA0), // Customize the color if needed
//             ),
//           ),
//           child: child!,
//         );
//       },
//       initialEntryMode: DatePickerEntryMode.input,
//       initialDatePickerMode: DatePickerMode.year,
//     );

//     if (selectedDate != null) {
//       // Handle the selected date
//       // You can update your UI or perform any necessary operations with the selected date
//       String formattedDate = DateFormat('MMMM yyyy').format(selectedDate);
//       print('Selected date: $formattedDate');
//     }
//   }
// }
