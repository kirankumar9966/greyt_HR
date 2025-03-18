import 'package:get/get.dart';

import '../controllers/edti_pin_controller.dart';

class EdtiPinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EdtiPinController>(
      () => EdtiPinController(),
    );
  }
}
