import 'package:get/get.dart';

class CasualLeaveController extends GetxController {
  //TODO: Implement CasualLeaveController
  var selectedMonthIndex = 0.obs;

  RxList<double> consumed = [-1.5, -0.5, -2.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0].obs;
  RxList<double> balance = [7.0, 6.5, 6.0, 6.0, 6.0, 6.0, 6.0, 6.0, 6.0, 6.0, 6.0, 6.0].obs;
  RxList<double> granted = [7.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0].obs;
  RxList<double> openingBalance = [0.0, 7.0, 6.5, 6.0, 6.0, 6.0, 6.0, 6.0, 6.0, 6.0, 6.0, 6.0].obs;

  final List<String> months = [
    "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
  ];

  void updateSelectedMonth(int index) {
    selectedMonthIndex.value = index;
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
