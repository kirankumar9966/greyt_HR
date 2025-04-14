import 'package:get/get.dart';

class PayslipsController extends GetxController {
  //TODO: Implement PayslipsController

  var selectedYear ="2025".obs;
  List<String> years = ["2023", "2024", "2025"];

  void updateYear(String year) {
    selectedYear.value = year;
  }


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
