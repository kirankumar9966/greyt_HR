import 'package:get/get.dart';

import '../controllers/payslip_details_controller.dart';

class PayslipDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PayslipDetailsController>(
      () => PayslipDetailsController(),
    );
  }
}
