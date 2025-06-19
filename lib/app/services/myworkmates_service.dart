import 'dart:convert';
import 'package:http/http.dart' as http;
import '../ApiConstants/api_constants.dart';
import 'auth_service.dart';

class MyWorkmatesService {
  static Future<List<Map<String, dynamic>>> fetchAllEmployeeDetails() async {
    try {

      final token = AuthService.getToken();
      print("Auth token: $token");
      // final token = AuthService.token;
      // print(token);
      if (token == null || token.isEmpty) {
        throw Exception('Authentication token is missing.');
      }

      final response = await http.post(
        Uri.parse(ApiConstants.getAllEmployeeDetails),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({}), // adjust if needed
      );

      print("API response: ${response.body}");

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        if (decoded['status'] == 'success' && decoded['data'] != null) {
          final List employees = decoded['data']['employees'];

          return employees.map<Map<String, dynamic>>((e) => {
            'id': e['emp_id'] ?? '',
            'name': "${e['first_name'] ?? ''} ${e['last_name'] ?? ''}".trim(),
            'jobRole': e['job_role'] ?? '',
            'hireDate': e['hire_date'] ?? '',
            'employeeType': e['employee_type'] ?? '',
            'status': e['employee_status'] ?? '',
            'gender': e['gender'] ?? '',
            'emergencyContact': e['emergency_contact'] ?? '',
            'companyName': (e['company_details'] != null && e['company_details'].isNotEmpty)
                ? e['company_details'][0]['company_name'] ?? ''
                : '',
            'department': e['emp_department']?['department'] ?? '',
            'subDepartment': e['emp_sub_department']?['sub_department'] ?? '',
          }).toList();
        } else {
          throw Exception("Unexpected response format or data missing.");
        }
      } else {
        throw Exception("Failed to fetch: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("API error: $e");
      rethrow;
    }
  }
}
