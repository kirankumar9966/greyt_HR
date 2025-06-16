import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;



class RegularisationHistoryDetailsPageController extends GetxController {
  var isLoading = true.obs;
  var data = {}.obs;
  String? employeeFullName;
  String? ShiftStart;
  String? ShiftEnd;
  Future<void> fetchEmployeeName() async {
    final token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjE2OC4xLjM4OjgwMDAvYXBpL2xvZ2luIiwiaWF0IjoxNzUwMDU0NDQ2LCJleHAiOjE3NTAwNjE2NDYsIm5iZiI6MTc1MDA1NDQ0NiwianRpIjoiMUl4ZkNNRkJucGFsU1dyRSIsInN1YiI6IlhTUy0wMzA3IiwicHJ2IjoiMzRjNDhmOTlmOTNhZWI3Nzc4YjkyZGEyNWZkNTYyYTI2ODVjYjYyNiJ9.UZI4tbzx4ZcHTkp-VdnweZEpEpMcGlrVvPKyaQd6Duw'; // Replace with your actual token

    final url = Uri.parse('http://192.168.1.38:8000/api/getEmployeeDetails');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final employee = data['data']['employee'];
      final shiftTime=data['data']['employee']['matching_shift'];
      final ShiftStartTime=shiftTime['shift_start_time'];
      final ShiftEndTime=shiftTime['shift_end_time'];
      final firstName = employee['first_name'];
      final lastName = employee['last_name'];
      ShiftStart= ShiftStartTime;
      ShiftEnd= ShiftEndTime;
      employeeFullName = '$firstName $lastName';



    } else {
      print('Error: ${response.statusCode}');
      print('Body: ${response.body}');
    }
  }


  Future<void> fetchRegularisationData(int id, String token) async {
     isLoading.value = true;



    final url = Uri.parse('http://192.168.1.38:8000/api/regularisation-history/$id');



     final response = await http.post(
    url,
    headers: {
           'Authorization': 'Bearer $token',
           'Accept': 'application/json',
        },
     );



     if (response.statusCode == 200) {
     final jsonResponse = json.decode(response.body);
     data.value = jsonResponse['data'];
     print('parr and mani');
     print(data.value['regularisation_entries']);
     print('divya and nikhitha');
     print(data.value['entries_count']);
    } else {
           data.value = {};
           print("Error: ${response.body}");
    }

     final employeeDetailsUrl = Uri.parse('http://192.168.1.38:8000/api/getEmployeeDetails');
     final employeeDetailsResponse = await http.post(
       employeeDetailsUrl,
       headers: {
         'Authorization': 'Bearer $token',
         'Accept': 'application/json',
       },
     );

     if (employeeDetailsResponse.statusCode == 200) {
       final employeeJson = json.decode(employeeDetailsResponse.body);
       print('Parr EmployeeDetails');
       print(employeeJson);
       // Store the shift times directly into the existing data map
       data.value['shift_start_time'] = employeeJson['data']['employee']['matching_shift']['shift_start_time'];
       data.value['shift_end_time'] = employeeJson['data']['employee']['matching_shift']['shift_end_time'];
       print('Shift Start: ${data.value['shift_start_time']}');
       print('Shift End: ${data.value['shift_end_time']}');
     } else {
       print("Error fetching employee details: ${employeeDetailsResponse.body}");
     }


    isLoading.value = false;
  }
}
