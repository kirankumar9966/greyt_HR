import 'package:get/get.dart';

class LeaveBalanceController extends GetxController {
  //TODO: Implement LeaveBalanceController

  final leaveData = [
    {
      "title": "Loss Of Pay",
      "balance": "0",
      "granted": "0 granted",
      "consumed": "0 consumed",
    },
    {
      "title": "Casual Leave",
      "balance": "5.5",
      "granted": "7 granted",
      "consumed": "1.5 consumed",
    },
    {
      "title": "Earned Leave",
      "balance": "2.49",
      "granted": "2.49 granted",
      "consumed": "0 consumed",
    },
    {
      "title": "Sick Leave",
      "balance": "4.5",
      "granted": "7 granted",
      "consumed": "2.5 consumed",
    },
    {
      "title": "Paternity Leave",
      "balance": "0",
      "granted": "0 granted",
      "consumed": "0 consumed",
    },
  ].obs;

  // Toggle for "Show All" switch
  var showAll = false.obs;

  // Selected date range
  var selectedDateRange = "Jan 2025 - Dec 2025".obs;

  // Date ranges for the dropdown
  final dateRanges = ["Jan 2025 - Dec 2025", "Jan 2024 - Dec 2024"];

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
