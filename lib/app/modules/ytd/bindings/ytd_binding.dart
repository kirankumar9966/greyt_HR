import 'package:get/get.dart';

import '../controllers/ytd_controller.dart';

class YtdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<YtdController>(
      () => YtdController(),
    );
  }
}
