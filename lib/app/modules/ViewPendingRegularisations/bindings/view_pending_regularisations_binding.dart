import 'package:get/get.dart';
import '../controllers/view_pending_regularisations_controller.dart';

class ViewPendingRegularisationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewPendingRegularisationsController>(
          () => ViewPendingRegularisationsController(),
    );
  }
}
