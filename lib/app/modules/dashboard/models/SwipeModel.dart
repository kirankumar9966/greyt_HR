import 'dart:convert';

SwipeModel swipeModelFromJson(String str) => SwipeModel.fromJson(json.decode(str));

class SwipeModel {
  final String status;
  final String message;
  final SwipeData data;

  SwipeModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SwipeModel.fromJson(Map<String, dynamic> json) => SwipeModel(
    status: json["status"],
    message: json["message"],
    data: SwipeData.fromJson(json["data"]),
  );
}

class SwipeData {
  final String empId;
  final String swipeTime;
  final String inOrOut;
  final String signInDevice;
  final String deviceName;
  final String deviceId;
  final String swipeLocation;
  final String swipeRemarks;
  final String shiftTime;

  SwipeData({
    required this.empId,
    required this.swipeTime,
    required this.inOrOut,
    required this.signInDevice,
    required this.deviceName,
    required this.deviceId,
    required this.swipeLocation,
    required this.swipeRemarks,
    required this.shiftTime,
  });

  factory SwipeData.fromJson(Map<String, dynamic> json) => SwipeData(
    empId: json["emp_id"],
    swipeTime: json["swipe_time"],
    inOrOut: json["in_or_out"],
    signInDevice: json["sign_in_device"],
    deviceName: json["device_name"],
    deviceId: json["device_id"],
    swipeLocation: json["swipe_location"],
    swipeRemarks: json["swipe_remarks"],
    shiftTime: json["shift_time"],
  );
}
