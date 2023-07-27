class AttendanceData {
  final String checkIn;
  final String checkOut;

  AttendanceData({this.checkIn = "", this.checkOut =""});

  factory AttendanceData.fromJson(Map<String, dynamic> json) {
    return AttendanceData(
      checkIn: json['checkIn'] ?? '',
      checkOut: json['checkOut'] ?? '',
    );
  }
}