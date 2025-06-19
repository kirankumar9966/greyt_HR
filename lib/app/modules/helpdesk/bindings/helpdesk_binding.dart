import 'package:get/get.dart';

import '../controllers/helpdesk_controller.dart';

class HelpdeskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HelpdeskController>(
      () => HelpdeskController(),
    );
  }
}
