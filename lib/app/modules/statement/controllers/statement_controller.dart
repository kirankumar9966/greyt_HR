import 'package:get/get.dart';

class StatementController extends GetxController {
  //TODO: Implement StatementController

  var selectedTabIndex = 0.obs;
  var taxRegime = "New Tax Regime".obs;
  var month = "Jan 2025".obs;

  // Summary
  var taxableIncome = 280008.00.obs;
  var annualTax = 0.0.obs;
  var totalPaid = 0.0.obs;

  // Detailed
  var income = 355008.00.obs;
  var deduction = 20304.00.obs;
  var perquisites = 0.0.obs;
  var incomeexcludedfromtax = 0.obs;
  var grosssalary = 20304.00.obs;
  var exemptionundersection = 0.0.obs;


  void onTabChange(int index) => selectedTabIndex.value = index;

  void onCardTap(String label) {
    // Show details for A, B, C
    Get.snackbar("Tapped", "Tapped on $label section");
  }

  void onDownloadTap() {
    // Placeholder for download logic
    Get.snackbar("Download", "IT Statement Download Initiated");
  }
}

// final count = 0.obs;
// @override
// void onInit() {
//   super.onInit();
// }
//
// @override
// void onReady() {
//   super.onReady();
// }
//
// @override
// void onClose() {
//   super.onClose();
// }

//   void increment() => count.value++;
//
// }
