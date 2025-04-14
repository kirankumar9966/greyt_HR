import 'package:get/get.dart';

import '../controllers/casual_leave_controller.dart';

class CasualLeaveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CasualLeaveController>(
      () => CasualLeaveController(),
    );
  }
}
