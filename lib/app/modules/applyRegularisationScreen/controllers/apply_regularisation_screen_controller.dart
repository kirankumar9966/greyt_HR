import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

class ApplyRegularisationScreenController extends ChangeNotifier {
  final String baseUrl = 'http://192.168.1.38:8000';
  String? employeeId;
  Map<String, dynamic>? _managerDetails;

  bool isLoading = false;
  String? error;
  String token='eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjE2OC4xLjM4OjgwMDAvYXBpL2xvZ2luIiwiaWF0IjoxNzUwMDcyNDMxLCJleHAiOjE3NTAwNzk2MzEsIm5iZiI6MTc1MDA3MjQzMSwianRpIjoicThuMGRUSXZqS1JlWXNhRCIsInN1YiI6IlhTUy0wMzA3IiwicHJ2IjoiMzRjNDhmOTlmOTNhZWI3Nzc4YjkyZGEyNWZkNTYyYTI2ODVjYjYyNiJ9.UxPgjmT_-al3yuGlEonMwkH913QKEdTZeN11hKWOPDc';
  Map<String, dynamic>? get managerDetails => _managerDetails;

  /// Fetches employee ID using token authentication.
  Future<String?> fetchEmployeeId() async {
    final response = await http.post(
      Uri.parse('http://192.168.1.38:8000/api/getEmployeeDetails'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        // Add auth header if needed
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Employee data: $data');
      return data['emp_id']; // or adjust based on your actual structure
    } else {
      print('Failed to load employee details');
      return null;
    }
  }


  /// Fetches manager details using managerId.
  Future<Map<String, dynamic>> fetchManagerDetails(String managerId) async {
    final url = Uri.parse('$baseUrl/api/getEmployeeDetails?manager_id=$managerId');

    final response = await http.post(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> managerDetails = json.decode(response.body);
      print('👔 Manager Details: $managerDetails');
      return managerDetails;
    } else {
      throw Exception('Failed to load manager details');
    }
  }

  /// Calls fetchManagerDetails and stores data.
  void getManagerDetailsAndProcess(String managerId) async {
    try {
      isLoading = true;
      notifyListeners();

      _managerDetails = await fetchManagerDetails(managerId);

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      error = e.toString();
      notifyListeners();
      print('⚠️ Error fetching manager details: $error');
    }
  }

  /// Called when Apply button is pressed.
  void onApply() {
    // Add your actual logic here
    print('Apply pressed. Selected Dates: ');
  }
}
