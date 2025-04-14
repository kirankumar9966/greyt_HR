import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:greyt_hr/app/services/dashboard_service.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../models/HolidayCalender.dart';
import '../../../services/auth_service.dart';
import '../../profile/controllers/profile_controller.dart';
import '../../utils/helpers.dart';

class DashboardController extends GetxController {

  var isSignedIn = false.obs;
  var swipeTime = ''.obs;
  var currentTime = ''.obs;
  var currentDate = ''.obs;
  var firstName = ''.obs;
  var lastName = ''.obs;
  var upcomingHolidays = <Holiday>[].obs;
  var isHolidayLoading = false.obs;

  // Sample salary values
  var  netPay = ''.obs;
  var  grossPay = ''.obs;
  var  deductions = ''.obs;
  var  monthOfSalary = ''.obs;

  var showNetPay = false.obs;
  var showGrossPay = false.obs;
  var showDeductions = false.obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  var userInitials = 'OK'.obs; // Replace with dynamic user data

  // Sidebar open/close state
  var isSidebarOpen = false.obs;

  // Toggle sidebar

  String formatMonth(String rawDate) {
    try {
      final date = DateTime.parse("$rawDate-01");
      return "${_monthName(date.month)} ${date.year}";
    } catch (e) {
      return rawDate;
    }
  }

  String _monthName(int month) {
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month];
  }

  Future<void> fetchSalaryDetails() async{
    isLoading.value = true;
    final response = await DashboardService.payslip();


    if (response['status'] == 'success') {
      print("kirann");
      final data = response['data'];
      final components = data['salary_components'];
      netPay.value = components['net_pay'].toString();
      grossPay.value = components['gross'].toString();
      deductions.value = components['total_deductions'].toString();
      monthOfSalary.value = formatMonth(data['month_of_salary']);

      errorMessage.value = '';
      isLoading.value = false;
    } else {
      errorMessage.value = response['message'] ?? 'Failed to fetch payslip';
    }

    isLoading.value = false;


  }



  var isSidebarVisible = false.obs;

  void toggleSidebar() {
    isSidebarVisible.value = !isSidebarVisible.value;
  }

  // Logout action
  void logout() {
    print("User logged out");
  }


  // Optional: Fetch user initials dynamically if required
  void fetchUserInitials(String firstName, String lastName) {
    final initials = "${firstName[0]}${lastName[0]}".toUpperCase();
    userInitials.value = initials;
  }

  @override
  void onInit() async {
    super.onInit();
    await fetchSalaryDetails();
    _updateTime(); // Start updating time
    _startClock();
    if (AuthService.getToken() != null && AuthService.getEmpId() != null) {
      performSwipe();
    }
    fetchUpcomingHolidays();
  }

  void _updateTime() {
    _setCurrentDateTime();
    Timer.periodic(const Duration(seconds: 1), (_) {
      _setCurrentDateTime();
    });
  }


  void _setCurrentDateTime() {
    final now = DateTime.now();
    currentTime.value = DateFormat('hh:mm a').format(now);
    currentDate.value = DateFormat('dd MMMM yyyy').format(now);
  }

  // 👇 This hits the swipe API and updates the status


  void _startClock() {
    currentTime.value = _formatTime(DateTime.now());
    currentDate.value = _formatDate(DateTime.now());

    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      final now = DateTime.now();
      currentTime.value = _formatTime(now);
      currentDate.value = _formatDate(now);
      return true;
    });
  }
  Future<void> fetchUpcomingHolidays() async {
    try {
      isHolidayLoading(true);
      final response = await http.get(Uri.parse("https://s6.payg-india.com/api/holidays"));

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final model = HolidayCalendarModel.fromJson(decoded);

        final today = DateTime.now();

        final filtered = model.data.holidays.where((h) {
          final holidayDate = DateTime.parse(h.date);
          return holidayDate.isAfter(today) || holidayDate.isAtSameMomentAs(today);
        }).take(4).toList();

        upcomingHolidays.assignAll(filtered);
      } else {
        Future.delayed(Duration.zero, () {
          Get.snackbar("Error", "Failed to fetch holidays");
        });
      }
    } catch (e) {
      Future.delayed(Duration.zero, () {
        Get.snackbar("Error", "Something went wrong");
      });
      print("Holiday fetch error: $e");
    } finally {
      isHolidayLoading(false);
    }
  }




  String _formatTime(DateTime time) =>
      '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(
          2, '0')}:${time.second.toString().padLeft(2, '0')}';

  String _formatDate(DateTime time) =>
      '${time.day.toString().padLeft(2, '0')}-${time.month.toString().padLeft(
          2, '0')}-${time.year}';

  Future<void> performSwipe() async {
    try {
      final token = AuthService.getToken();
      final empId = AuthService.getEmpId();



      if (token == null || empId == null) {
        Get.snackbar("Error", "Missing token or emp_id");
        return;
      }

      final direction = isSignedIn.value ? "OUT" : "IN";


      final response = await http.post(
        Uri.parse("https://s6.payg-india.com/api/swipe"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "emp_id": empId,
          "in_or_out": direction,
        }),
      );



      final body = jsonDecode(response.body);

      if (response.statusCode == 200 && body['status'] == 'success') {
        final data = body['data'];

        swipeTime.value = data['swipe_time'] ?? '';
        isSignedIn.value = data['in_or_out'] == "IN";

        showSuccessFlash(
            data['in_or_out'] == "IN"
                ? "Sign In successful"
                : "Sign Out successful"
        );
        // ✅ Get full name from API
        final String? firstName = data['first_name'];
        final String? lastName = data['last_name'];

        if (firstName != null && lastName != null) {
          print("🧑 Hello, $firstName $lastName");
          // Or store it if you want to show later:
          // fullName.value = "$firstName $lastName";
        }

      } else {

        Get.snackbar("Failed", body["message"] ?? "Swipe failed");
      }
    } catch (e) {

      Get.snackbar("Error", "Something went wrong");
    }
  }




}
