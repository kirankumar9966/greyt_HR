import 'package:get/get.dart';

import '../controllers/regularization_controller.dart';

class RegularizationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegularizationController>(
      () => RegularizationController(),
    );
  }
}
