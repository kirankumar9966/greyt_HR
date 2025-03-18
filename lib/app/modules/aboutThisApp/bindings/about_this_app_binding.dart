import 'package:get/get.dart';

import '../controllers/about_this_app_controller.dart';

class AboutThisAppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutThisAppController>(
      () => AboutThisAppController(),
    );
  }
}
