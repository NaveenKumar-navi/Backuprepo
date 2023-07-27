class ApiEndPoints {
  static const String baseUrl = 'https://d7a6-2401-4900-1ce0-3d5a-f4e3-115a-de04-eab5.ngrok-free.app/';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String loginEmail = 'auth/login';
  final String punch = 'employee/attendance/punch';
  final String getByDatePunchData = 'employee/attendance/getByDate';
  final String getByAttendanceList = 'employee/attendance/getByEmployee';
}