import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

class ProfileModel {
  final String status;
  final String message;
  final ProfileData data;

  ProfileModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    status: json["status"],
    message: json["message"],
    data: ProfileData.fromJson(json["data"]),
  );
}

class ProfileData {
  final Employee employee;

  ProfileData({required this.employee});

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
    employee: Employee.fromJson(json["employee"]),
  );
}

class Employee {
  final String empId;
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final List<String> companyId;
  final String jobRole;
  final String image;
  final String jobLocation;
  final String employeeStatus;
  final String serviceAge;
 final String hireDate;


  Employee({
    required this.empId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.companyId,
    required this.jobRole,
    required this.image,
    required this.jobLocation,
    required this.employeeStatus,
    required this.serviceAge,
    required this.hireDate,

  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    empId: json["emp_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    gender: json["gender"],
    companyId: List<String>.from(json["company_id"].map((x) => x)),
    jobRole: json["job_role"],
    image: json["image"],
    jobLocation: json["job_location"],
    employeeStatus: json["employee_status"],
    serviceAge: json["service_age"],
    hireDate: json["hire_date"],

  );
}
