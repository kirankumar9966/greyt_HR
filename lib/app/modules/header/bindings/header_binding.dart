import 'package:get/get.dart';

import '../controllers/header_controller.dart';

class HeaderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HeaderController>(
      () => HeaderController(),
    );
  }
}
