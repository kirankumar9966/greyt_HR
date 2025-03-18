import 'package:get/get.dart';

import '../controllers/holiday_calender_controller.dart';

class HolidayCalenderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HolidayCalenderController>(
      () => HolidayCalenderController(),
    );
  }
}
