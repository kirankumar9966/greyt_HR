import 'package:get/get.dart';

import '../controllers/attendance_info_controller.dart';

class AttendanceInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AttendanceInfoController>(
      () => AttendanceInfoController(),
    );
  }
}
