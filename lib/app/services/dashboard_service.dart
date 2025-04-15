import 'dart:convert';
import 'package:greyt_hr/app/ApiConstants/api_constants.dart';
import 'package:greyt_hr/app/services/auth_service.dart';
import 'package:http/http.dart' as http;

class DashboardService {
  static Future<Map<String, dynamic>> latestPayslip() async {
    final token = AuthService.getToken();

    if (token == null) {
      return {
        'status': 'error',
        'message': 'Unauthorized or missing employee ID',
      };
    }

    try {
      final url = Uri.parse(ApiConstants.showSalary);
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data["status"] == "success") {
          return {"status": "success", "data": data["data"]};
        } else {
          return {
            "status": "error",
            "message": data["message"] ?? 'Failed to fetch salary',
          };
        }
      } else {
        return {
          "status": "error",
          "message": "Failed with status ${response.statusCode}",
        };
      }
    } catch (e) {
      return {"status": "error", "message": "Exception occurred: $e"};
    }
  }
  static Future<Map<String, dynamic>> payslip({
    required String month,
    required String year,
  }) async {
    final token = AuthService.getToken();

    if (token == null) {
      return {
        'status': 'error',
        'message': 'Unauthorized or missing employee ID',
      };
    }

    try {
      final url = Uri.parse(ApiConstants.showSalary);

      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'month': month,
          'year': year,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data["status"] == "success") {
          return {"status": "success", "data": data["data"]};
        } else {
          return {
            "status": "error",
            "message": data["message"] ?? 'Failed to fetch salary',
          };
        }
      } else {
        return {
          "status": "error",
          "message": "Failed with status ${response.statusCode}",
        };
      }
    } catch (e) {
      return {"status": "error", "message": "Exception occurred: $e"};
    }
  }
}
