import 'package:get/get.dart';

import '../controllers/apply_leave_controller.dart';

class ApplyLeaveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplyLeaveController>(
      () => ApplyLeaveController(),
    );
  }
}
