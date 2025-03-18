import 'package:get/get.dart';

import '../controllers/day_details_controller.dart';

class DayDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DayDetailsController>(
      () => DayDetailsController(),
    );
  }
}
