import 'package:get/get.dart';

import '../controllers/disable_pin_controller.dart';

class DisablePinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DisablePinController>(
      () => DisablePinController(),
    );
  }
}
