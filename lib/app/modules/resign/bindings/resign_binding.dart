import 'package:get/get.dart';

import '../controllers/resign_controller.dart';

class ResignBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResignController>(
      () => ResignController(),
    );
  }
}
