import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


import '../../../services/auth_service.dart';

import '../../../services/dashboard_service.dart';
import '../../utils/helpers.dart';
import '../models/HolidayCalender.dart';


class DashboardController extends GetxController {

  var isSignedIn = false.obs;
  var swipeTime = ''.obs;
  // Reset old data
  var swipeStatus = ''.obs;

  var shiftTime = ''.obs;

  var currentTime = ''.obs;
  var currentDate = ''.obs;
  var firstName = ''.obs;
  var lastName = ''.obs;
  var upcomingHolidays = <Holiday>[].obs;
  var isHolidayLoading = false.obs;
  var isSwiping = false.obs;
 // Add this

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

  RxList<Holiday> allHolidays = <Holiday>[].obs;
  RxList<Holiday> filteredHolidays = <Holiday>[].obs;
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
    final response = await DashboardService.latestPayslip();


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
    swipeTime.value = '';
    isSignedIn.value = false;
    fetchHolidays();
      // Ensure token is set before calling this
    fetchSwipeStatus();
    _updateTime(); // Start updating time
    _startClock();





  }




  Future<void> fetchHolidays() async {
    final token = AuthService.getToken();
    final empId = AuthService.getEmpId();

    if (token == null || empId == null) {
      Get.snackbar("Error", "Login token or empId missing");
      return;
    }

    try {
      isHolidayLoading.value = true;

      final response = await http.post(
        Uri.parse("https://s6.payg-india.com/api/holidays"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final model = HolidayCalendarModel.fromJson(data);
        allHolidays.assignAll(model.data.holidays);

        // ✅ Filter only upcoming holidays from today
        final today = DateTime.now();
        final upcoming = model.data.holidays.where((holiday) {
          final date = DateTime.tryParse(holiday.date);
          return date != null && !date.isBefore(today);
        }).toList();

        // ✅ Sort by date and take the latest 4
        upcoming.sort((a, b) => a.date.compareTo(b.date));
        upcomingHolidays.assignAll(upcoming.take(4));
      } else {
        Get.snackbar("Error", "Failed to load holidays");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isHolidayLoading.value = false;
    }
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








  String _formatTime(DateTime time) =>
      '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(
          2, '0')}:${time.second.toString().padLeft(2, '0')}';

  String _formatDate(DateTime time) =>
      '${time.day.toString().padLeft(2, '0')}-${time.month.toString().padLeft(
          2, '0')}-${time.year}';


  void performSwipe(String inOrOut) async {
    await AuthService.performSwipe(inOrOut);
  }


  void updateSwipeUI(bool signedIn, String time, String shift) {
    isSignedIn.value = signedIn;
    swipeTime.value = time;
    shiftTime.value = shift;
  }


  Future<void> fetchSwipeStatus() async {
    final token = AuthService.getToken();
    final empId = AuthService.getEmpId();

    if (token == null || empId == null) {
      Get.snackbar("Error", "Missing credentials");
      return;
    }

    final url = Uri.parse("https://s6.payg-india.com/api/swipe-status");

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({"emp_id": empId}),
      );

      final body = jsonDecode(response.body);
      print("📩 Swipe Status Response: ${response.body}");

      if (response.statusCode == 200 && body['status'] == 'success') {
        final data = body['data'];
        isSignedIn.value = data['swipe_status'] == 'IN';
        swipeTime.value = data['last_swipe_time'] ?? '';
      } else {
        Get.snackbar("Error", body["message"] ?? "Failed to fetch swipe status");
      }
    } catch (e) {
      print("❌ Error fetching swipe status: $e");
      Get.snackbar("Error", "Something went wrong");
    }
  }



// Function to refresh swipe data on user login
  void refreshSwipeData() async {
    final token = AuthService.getToken();
    final empId = AuthService.getEmpId();

    if (token == null || empId == null) {
      return;
    }

    final response = await http.post(
      Uri.parse("https://s6.payg-india.com/api/swipe"),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    final body = jsonDecode(response.body);
    print("🔄 Refresh API Response: $body");

    if (response.statusCode == 200 && body['status'] == 'success') {
      final data = body['data'];

      if (data['emp_id'].toString() == empId.toString()) {
        swipeTime.value = data['swipe_time'] ?? '';
        isSignedIn.value = data['in_or_out'] == "IN";
        shiftTime.value = data['shift_time'] ?? '';

        print("✅ Refreshed Data for emp_id: $empId");
      }
    }
  }






}
