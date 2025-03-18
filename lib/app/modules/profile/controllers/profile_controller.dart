import 'package:get/get.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  var extensionNo = "-".obs;
  var location = "Hyderabad".obs;
  var joiningDate = "02 Jan, 2023".obs;
  var dateOfBirth = "03 Mar".obs;
  var employeeName = "Obula Kiran Kumar".obs;
  var employeeID = "XSS-0474".obs;

  // Simulating a fetch method
  void fetchProfileData() {
    // Fetch or update the data from API or database
    extensionNo.value = "9381694712";
    location.value = "Hyderabad";
    joiningDate.value = "02 Jan, 2023";
    dateOfBirth.value = "12 Apr";
    employeeName.value = "Obula Kiran Kumar";
    employeeID.value = "XSS-0474";
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    fetchProfileData();
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
