import 'dart:convert';
import 'package:http/http.dart' as http;
import '../ApiConstants/api_constants.dart';
import 'auth_service.dart';

class ChangePasswordService {

  static Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final token = AuthService.getToken();

    if (token == null) {
      return {
        'status': 'error',
        'message': 'User not authenticated',
      };
    }

    try {
      final url = Uri.parse(ApiConstants.changePassword);
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: {
          'current_password': currentPassword,
          'new_password': newPassword,
          'new_password_confirmation': confirmPassword,
        },
      );

      final data = jsonDecode(response.body);
      return data;
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Something went wrong: $e',
      };
    }
  }
}
