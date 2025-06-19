import 'package:get/get.dart';
import 'package:greyt_hr/app/modules/reviewPendingRegularisation/controllers/review_pending_regularisation_controller.dart';

class ReviewPendingRegularisationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewPendingRegularisationController>(
          () => ReviewPendingRegularisationController(),
    );
  }
}
