class Employee {
  String firstName;
  String email;
  String designation;
  String mobileNo;
  String address;


Employee({
    required this.firstName,
    required this.email,
    required this.designation,
    required this.mobileNo,
    required this.address,
  });

factory Employee.fromJson(Map<dynamic,dynamic>json){
  return Employee(
    firstName: json['empName']??'',
    email: json['email']??'', 
    designation: json['designation']??'', 
    mobileNo: json['mobileNo']??'',
    address: json['address']??''
    );
}
}