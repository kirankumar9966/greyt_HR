import 'dart:convert';

Engage engageFromJson(String str) => Engage.fromJson(json.decode(str));

class Engage {
  String status;
  String message;
  List<Datum> data;

  Engage({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Engage.fromJson(Map<String, dynamic> json) => Engage(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );
}

class Datum {
  String date;
  Type type;
  String time;
  String message;
  Employee employee;

  Datum({
    required this.date,
    required this.type,
    required this.time,
    required this.message,
    required this.employee,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    date: json["date"],
    type: typeValues.map[json["type"]]!,
    time: json["time"],
    message: json["message"],
    employee: Employee.fromJson(json["employee"]),
  );
}

class Employee {
  String empId;
  String name;
  DateTime? dateOfBirth;
  DateTime? hireDate;
  String? image; // base64 blob string

  Employee({
    required this.empId,
    required this.name,
    this.dateOfBirth,
    this.hireDate,
    required this.image,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    empId: json["emp_id"],
    name: json["name"],
    dateOfBirth: json["date_of_birth"] == null
        ? null
        : DateTime.parse(json["date_of_birth"]),
    hireDate: json["hire_date"] == null
        ? null
        : DateTime.parse(json["hire_date"]),
    image: json["image"], // Accepts null or base64 string
  );
}

enum Type { DATE_OF_BIRTH, HIRE_DATE }

final typeValues = EnumValues({
  "date_of_birth": Type.DATE_OF_BIRTH,
  "hire_date": Type.HIRE_DATE,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map) {
    reverseMap = map.map((k, v) => MapEntry(v, k));
  }

  Map<T, String> get reverse => reverseMap;
}
