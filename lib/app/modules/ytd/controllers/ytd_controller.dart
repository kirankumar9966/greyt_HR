import 'package:get/get.dart';

class YtdController extends GetxController {
  var selectedTab = 0.obs;

  void changeTab(int index) {
    selectedTab.value = index;
  }

  void downloadYTD() {
    // Implement download logic for YTD
    print("Downloading YTD Statement...");
  }

  void downloadPFYTD() {
    // Implement download logic for PFYTD
    print("Downloading PFYTD Statement...");
  }
}

void downloadYTD() {
  // This is a placeholder – show a snackbar for now
  Get.snackbar('Download', 'YTD Statement download initiated',
      snackPosition: SnackPosition.BOTTOM);
}
void downloadPFYTD() {
  // Placeholder logic for download
  Get.snackbar('Download', 'PFYTD Statement download initiated',
      snackPosition: SnackPosition.BOTTOM);
}

var months = ['Apr 2024 - Mar 2025'].obs;
var selectedMonth = 0.obs;

var generatedMonth = 'Feb 2025'.obs;
var totalAmount = '45,392.00'.obs;

var employeeNo = 'XSS-0372'.obs;
var employeeName = 'PADMAVATHI VYDA'.obs;
var joinDate = '19 Apr 2021'.obs;
var pfNumber = 'AP/HYD/0056226/000/0010185'.obs;
var uan = '101680808917'.obs;

void downloadStatement() {
  // Download logic here
  print("Downloading PF YTD Statement...");
}

void selectMonth(int index) {
  selectedMonth.value = index;
}


