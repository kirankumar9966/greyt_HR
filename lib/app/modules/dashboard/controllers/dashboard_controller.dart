import 'dart:async';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DashboardController extends GetxController {
  // Observable variables
  var currentTime = ''.obs;
  var currentDate = ''.obs;
  RxBool showNetPay = false.obs;
  RxBool showGrossPay = false.obs;
  RxBool showDeductions = false.obs;

  var userInitials = 'OK'.obs; // Replace with dynamic user data

  // Sidebar open/close state
  var isSidebarOpen = false.obs;

  // Toggle sidebar


  // Sample salary values
  final String netPay = "50,000.00";
  final String grossPay = "70,000.00";
  final String deductions = "20,000.00";


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
  void onInit() {
    super.onInit();
    _updateTime(); // Start updating time
  }

  void _updateTime() {
    // Initialize the date and time
    _setCurrentDateTime();
    // Update time every second
    Timer.periodic(const Duration(seconds: 1), (_) {
      _setCurrentDateTime();
    });
  }

  void _setCurrentDateTime() {
    final now = DateTime.now();
    currentTime.value = DateFormat('hh:mm a').format(now); // e.g., "10:46\nAM"
    currentDate.value = DateFormat('dd MMMM yyyy').format(now); // e.g., "24 February 2025"
  }
}
