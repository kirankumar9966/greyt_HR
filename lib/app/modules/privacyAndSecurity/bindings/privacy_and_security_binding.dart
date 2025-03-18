import 'package:get/get.dart';

import '../controllers/privacy_and_security_controller.dart';

class PrivacyAndSecurityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrivacyAndSecurityController>(
      () => PrivacyAndSecurityController(),
    );
  }
}
