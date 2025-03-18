import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UpdatesController extends GetxController {
  //TODO: Implement UpdatesController
  final count = 0.obs;

  // Reference to BuildContext
  final isUpdateAvailable = false.obs;


  @override
  void onInit() {
    super.onInit();
    checkForUpdates();
  }

  void checkForUpdates() {
    // Simulated logic: Set to false to indicate no updates
    isUpdateAvailable.value = false;
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
