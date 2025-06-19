import 'dart:convert';
import 'package:get/get.dart';
import 'package:greyt_hr/app/ApiConstants/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import '../modules/dashboard/controllers/dashboard_controller.dart';
import '../modules/dashboard/models/HolidayCalender.dart';
import '../modules/payslipDetails/controllers/payslip_details_controller.dart';
import '../modules/profile/controllers/profile_controller.dart';
import '../modules/myworkmates/controllers/myworkmates_controller.dart';
import '../modules/profile/models/ProfileModel.dart';
import '../modules/utils/ApiConstants.dart';
import '../routes/app_pages.dart';

class AuthService {
  static final GetStorage _storage = GetStorage();

  static const String baseUrl = "https://s6.payg-india.com/api/login";
  static const String profileUrl = "https://s6.payg-india.com/api/getEmployeeDetails";
  static const String holidaysUrl = "https://s6.payg-india.com/api/holidays";
  static const String swipeUrl = "https://s6.payg-india.com/api/swipe";
  static const String parse = "https://s6.payg-india.com/api/get-all-employeeDetails";
  static String token = "https://s6.payg-india.com/api/get-all-employeeDetails";

 // static String token = 'https://s6.payg-india.com/api/get-all-employeeDetails'; // Set your token here or fetch from secure storage




  static String? getToken() => _storage.read("auth_token");
  static String? getEmpId() => _storage.read("emp_id");
  static String? getSwipeTime() => _storage.read("swipe_time");
  static String? getInOrOut() => _storage.read("in_or_out");
  static bool isLoggedIn() => _storage.hasData("auth_token");
  var isSignedIn = false.obs;
  var swipeTime = ''.obs;
  var isSwiping = false.obs;
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
  static Future<List<dynamic>> fetchHolidays() async {
    final token = _storage.read("auth_token");

    if (token == null) {
      throw Exception("No auth token found. Please login.");
    }

    try {
      final response = await http.post(
        Uri.parse('https://s6.payg-india.com/api/holidays'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({}), // If your API expects a POST body, add here
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data["status"] == "success" && data["data"] != null) {
          return data["data"];
        } else {
          throw Exception("Failed to fetch holidays: ${data["message"]}");
        }
      } else {
        throw Exception("API Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      throw Exception("Failed to fetch holidays: $e");
    }
  }

  static Future<void> saveSwipeStatus(String empId, String swipeTime, String inOrOut) async {
    await _storage.write("emp_id", empId);
    await _storage.write("swipe_time", swipeTime);
    await _storage.write("in_or_out", inOrOut);
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
        return ProfileModel.fromJson(data); // 🔥 Error is likely here
      } else {
        print("⚠️ Failed to fetch profile: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("❌ Error fetching profile: $e");
      return null;
    }
  }


  static Future<void> performSwipe(String inOrOut) async {
    final token = getToken();
    final empId = getEmpId();

    if (token == null || empId == null) {
      Get.snackbar("Error", "Missing credentials");
      return;
    }

    final url = Uri.parse(swipeUrl);
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        "emp_id": empId,
        "in_or_out": inOrOut // ✅ Pass "IN" or "OUT"
      }),
    );

    print("📨 Swipe Response Body: ${response.body}");
    print("📨 Swipe Status Code: ${response.statusCode}");

    try {
      final body = jsonDecode(response.body);
      if (response.statusCode == 200 && body['status'] == 'success') {
        final data = body['data'];
        final signedIn = inOrOut == "IN";

        Get.find<DashboardController>().updateSwipeUI(
          signedIn,
          data['swipe_time'] ?? '',
          data['shift_time'] ?? '',
        );

        Get.snackbar("Success", "Sign $inOrOut recorded successfully");
      } else {
        Get.snackbar("Error", body["message"] ?? "Swipe failed");
      }
    } catch (e) {
      print("❌ Swipe parse error: $e");
      Get.snackbar("Error", "Unexpected response from server");
    }
  }



  static Future<void> fetchSwipeStatusOnLogin() async {
    final token = getToken();
    final empId = getEmpId();

    if (token == null || empId == null) return;

    try {
      final response = await http.post(
        Uri.parse("https://s6.payg-india.com/api/swipe"),
        headers: {'Authorization': 'Bearer $token'},
      );

      final body = jsonDecode(response.body);
      print("📨 Swipe Response Body: $body");
      print("📨 Swipe Status Code: ${response.statusCode}");

      if (response.statusCode == 200 && body['status'] == 'success') {
        final data = body['data'];
        final signedIn = data['in_or_out'] == "IN";
        final swipeTime = data['swipe_time'] ?? '';
        final shiftTime = data['shift_time'] ?? '';
        final empIdFromApi = data['emp_id'] ?? empId;

        // ✅ Save emp_id, swipe_time, and in_or_out locally
        await saveSwipeStatus(empIdFromApi, swipeTime, data['in_or_out'] ?? '');

        // ✅ Update UI
        Get.find<DashboardController>().updateSwipeUI(
          signedIn,
          swipeTime,
          shiftTime,
        );
      }
    } catch (e) {
      print("❌ Error loading initial swipe state: $e");
    }
  }




  static Future<void> saveToken(String token) async =>
      await _storage.write("token", token);
  static Future<void> saveEmpId(String empId) async =>
      await _storage.write("emp_id", empId);
  static void clearSession() => _storage.erase();
  // Logout Function
  static Future<void> logout() async {
    final token = getToken();

    try {
      if (token != null) {
        final response = await http.post(
          Uri.parse('https://s6.payg-india.com/api/logout'),
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          print("✅ Logout successful from API");
        } else {
          print("⚠️ Logout failed from API: ${response.body}");
        }
      } else {
        print("⚠️ No token found for logout");
      }
    } catch (e) {
      print("❌ Error during logout: $e");
    } finally {
      await _clearStorageAndRedirect();
    }
  }

  static Future<void> _clearStorageAndRedirect() async {
    await _storage.erase(); // 🔥 Clears all keys at once

    if (Get.isRegistered<ProfileController>()) {
      Get.delete<ProfileController>(force: true); // ✅ Fully remove controller
      print("🗑️ Deleted ProfileController");
    }

    if (Get.isRegistered<DashboardController>()) {
      Get.delete<DashboardController>(force: true); // Optional: reset swipe UI too
      print("🗑️ Deleted DashboardController");
    }
    if (Get.isRegistered<PayslipDetailsController>()) {
      Get.delete<PayslipDetailsController>(force: true); // Optional: reset swipe UI too
      print("🗑️ Deleted DashboardController");
    }
    print("🧹 Cleared storage and controllers");
    Get.offAllNamed(Routes.LOGIN);
  }





}
