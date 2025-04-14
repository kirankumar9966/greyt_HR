import 'dart:convert';
import 'package:get/get.dart';
import 'package:greyt_hr/app/ApiConstants/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import '../modules/profile/models/ProfileModel.dart';
import '../routes/app_pages.dart';

class AuthService {
  var swipeStatus = ''.obs;
  var swipeTime = ''.obs;
  var isSignedIn = false.obs;

  static final _storage = GetStorage();
  static const String baseUrl = "https://s6.payg-india.com/api/login";
  static const String profileUrl = "https://s6.payg-india.com/api/getEmployeeDetails";

  static String? getToken() => _storage.read("auth_token");
  static String? getEmpId() => _storage.read("emp_id");


  static bool isLoggedIn() => _storage.hasData("auth_token");

  static Future<Map<String, dynamic>> login(String empId, String password) async {
    try {
      final url = Uri.parse(ApiConstants.login);
      print("object,$url");
      print("object,$password");
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "emp_id": empId,
          "password": password,
        }),
      );

      print("kiran,$response.statusCode");
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data["status"] == "success" && data["data"] != null) {
          String token = data["data"]["access_token"];
          int expiresIn = data["data"]["expires_in"];

          await _storage.write("auth_token", token);
          await _storage.write("emp_id", empId);
          await _storage.write("expires_in", expiresIn);

          return {
            "status": "success",
            "message": data["message"],
            "token": token,
            "emp_id": empId,
          };
        } else {
          return {'status': 'error', 'message': 'Login failed'};
        }
      } else {
        return {'status': 'error', 'message': 'Invalid credentials'};
      }
    } catch (e) {
      return {'status': 'error', 'message': 'Something went wrong: $e'};
    }
  }

  static Future<ProfileModel?> fetchEmployeeDetails() async {
    try {
      final token = getToken();

      if (token == null) {
        print("⚠️ Token missing.");
        return null;
      }

      final url = Uri.parse(profileUrl);

      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ProfileModel.fromJson(data);
      } else {
        print("⚠️ Failed to fetch profile: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("❌ Error fetching profile: $e");
      return null;
    }
  }


  static Future<void> logout() async {
    print("🔐 Logging out...");
    await _storage.erase();
    print("🧹 Storage cleared");
    Future.delayed(Duration.zero, () {
      Get.offAllNamed(Routes.LOGIN);
    });
  }
}
