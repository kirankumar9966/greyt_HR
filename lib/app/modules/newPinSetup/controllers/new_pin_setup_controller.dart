import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NewPinSetupController extends GetxController {
  //TODO: Implement NewPinSetupController
  final List<TextEditingController> controllers =
  List.generate(4, (index) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());

  final count = 0.obs;

  void moveToNextField(int index) {
    if (index < controllers.length - 1) {
      focusNodes[index + 1].requestFocus();
    } else {
      focusNodes[index].unfocus();
    }
  }

  void moveToPreviousField(int index) {
    if (index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }

  String getPin() {
    return controllers.map((c) => c.text).join();
  }

  bool isPinComplete() {
    return getPin().length == 4;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.onClose();
  }

  void increment() => count.value++;
}
