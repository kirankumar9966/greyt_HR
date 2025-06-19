import 'package:get/get.dart';

import '../controllers/holidaycenter_controller.dart';

class HolidaycenterBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<HolidaycenterController>(
    //   () => HolidaycenterController(),
    // );
    Get.put(HolidaycenterController());

  }
}

