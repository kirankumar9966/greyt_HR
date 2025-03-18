import 'package:get/get.dart';

import '../controllers/payslips_controller.dart';

class PayslipsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PayslipsController>(
      () => PayslipsController(),
    );
  }
}
