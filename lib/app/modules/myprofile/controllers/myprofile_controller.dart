import 'package:get/get.dart';

class MyprofileController extends GetxController {
  //TODO: Implement MyprofileController
  var isResignationScreen = false.obs;

  // Profile data
  final name = 'PADMAVATHI VYDA';
  final empCode = 'XSS-0372';
  final extension = '-';
  final location = 'Hyderabad';
  final jobMode = 'Hybrid';
  final joiningDate = '19 Apr, 2021';
  final dob = '14 Oct';
  final status = 'Confirmed';

  void showResignationPage() {
    isResignationScreen.value = true;
  }

  void goBack() {
    isResignationScreen.value = false;
  }

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


