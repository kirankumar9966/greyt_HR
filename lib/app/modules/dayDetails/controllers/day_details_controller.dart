import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DayDetailsController extends GetxController {
  //TODO: Implement DayDetailsController
  var shiftStart = ''.obs;
  var shiftEnd = ''.obs;
  @override
  void onInit() {
    super.onInit();
    fetchEmployeeName();
  }

  Future<void> fetchEmployeeName() async {
    final token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjE2OC4xLjQ4OjgwMDAvYXBpL2xvZ2luIiwiaWF0IjoxNzQ4NTg2MzIwLCJleHAiOjE3NDg1OTM1MjAsIm5iZiI6MTc0ODU4NjMyMCwianRpIjoiczN3bHZRYzdXa2hsMlFWaSIsInN1YiI6IlhTUy0wNDc3IiwicHJ2IjoiMzRjNDhmOTlmOTNhZWI3Nzc4YjkyZGEyNWZkNTYyYTI2ODVjYjYyNiJ9.t56oWq2_h5apRiCRcZMChkWdViopCUb92ZEKMI2-pa8'; // Replace with your actual token

    final url = Uri.parse('http://192.168.1.48:8000/api/getEmployeeDetails');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      shiftStart.value = data['shift_start_time'] ?? 'N/A';
      shiftEnd.value = data['shift_end_time'] ?? 'N/A';

      // ShiftStart= ShiftStartTime;
      // ShiftEnd= ShiftEndTime;




    } else {
      print('Error: ${response.statusCode}');
      print('Body: ${response.body}');
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
