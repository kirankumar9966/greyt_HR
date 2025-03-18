import 'package:get/get.dart';

import '../controllers/apply_regularization_controller.dart';

class ApplyRegularizationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplyRegularizationController>(
      () => ApplyRegularizationController(),
    );
  }
}
