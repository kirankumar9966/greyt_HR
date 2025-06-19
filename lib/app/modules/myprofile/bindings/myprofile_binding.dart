import 'package:get/get.dart';

import '../controllers/myprofile_controller.dart';

class MyprofileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyprofileController>(
      () => MyprofileController(),
    );
  }
}
