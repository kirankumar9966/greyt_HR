import 'package:get/get.dart';

import '../controllers/new_pin_setup_controller.dart';

class NewPinSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewPinSetupController>(
      () => NewPinSetupController(),
    );
  }
}
