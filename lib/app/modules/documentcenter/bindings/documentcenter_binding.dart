import 'package:get/get.dart';

import '../controllers/documentcenter_controller.dart';

class DocumentcenterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DocumentcenterController>(
      () => DocumentcenterController(),
    );
  }
}
