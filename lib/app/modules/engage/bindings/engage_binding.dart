import 'package:get/get.dart';

import '../controllers/engage_controller.dart';

class EngageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EngageController>(
      () => EngageController(),
    );
  }
}
