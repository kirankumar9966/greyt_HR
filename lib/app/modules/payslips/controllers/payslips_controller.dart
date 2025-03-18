import 'package:get/get.dart';

class PayslipsController extends GetxController {
  //TODO: Implement PayslipsController

  var isExpanded =false.obs;

  void toggleExpansion(){
    isExpanded.value = !isExpanded.value;
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
