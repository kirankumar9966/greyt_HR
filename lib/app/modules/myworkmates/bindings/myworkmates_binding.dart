import 'package:get/get.dart';

import '../controllers/myworkmates_controller.dart';

class MyworkmatesBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<MyworkmatesController>(
    //   () => MyworkmatesController(),
    // );
    Get.put(MyworkmatesController());
  }
}
