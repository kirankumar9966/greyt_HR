import 'package:get/get.dart';

class ExploreController extends GetxController {
  //TODO: Implement ExploreController
  var expandedIndex = (-1).obs;
  void toggleExpansion(int index) {
    expandedIndex.value = expandedIndex.value == index ? -1 : index;
  }

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

}
