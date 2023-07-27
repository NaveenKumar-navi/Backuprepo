class EmployeeAttendance {
  final String checkIn;
  final String checkInLocation;
  final String checkOut;
  final String checkOutLocation;
  final String date;

  EmployeeAttendance({
    required this.checkIn,
    required this.checkInLocation,
    required this.checkOut,
    required this.checkOutLocation,
    required this.date,
  });

  factory EmployeeAttendance.fromJson(Map<dynamic, dynamic> json) {
    return EmployeeAttendance(
      checkIn: json['checkIn'] ?? '',
      checkInLocation: json['checkInLocation'] ?? '',
      checkOut: json['checkOut'] ?? '',
      checkOutLocation: json['checkOutLocation'] ?? '',
      date: json['date'] ?? '',
    );
  }
}
