import 'package:get/get.dart';

import '../controllers/footer_controller.dart';

class FooterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FooterController>(
      () => FooterController(),
    );
  }
}
