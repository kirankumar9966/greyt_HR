import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../dashboard/views/dashboard_view.dart';

class EdtiPinController extends GetxController {
  final List<TextEditingController> controllers = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());

  var pinMismatch = false.obs;
  var isButtonEnabled = false.obs;
  var step = 0.obs;

  String newPin = ""; // Stores the new PIN entered in step 1

  void moveToNextField(int index) {
    if (controllers[index].text.isNotEmpty) {
      if (index < focusNodes.length - 1) {
        focusNodes[index + 1].requestFocus();
      } else {
        focusNodes[index].unfocus();
      }
    } else if (index > 0 && controllers[index].text.isEmpty) {
      focusNodes[index - 1].requestFocus();
      controllers[index - 1].clear();
    }
    validateInputs();
  }

  void moveToPreviousField(int index) {
    if (index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }



  void validateInputs() {
    if (controllers.any((c) => c.text.isEmpty)) {
      isButtonEnabled.value = false;
      return;
    }

    if (step.value == 2) {
      String reEnterPin = controllers.map((c) => c.text).join();
      pinMismatch.value = newPin != reEnterPin;
    } else {
      pinMismatch.value = false;
    }

    isButtonEnabled.value = !pinMismatch.value;
  }

  void advanceToNextStep() {
    if (step.value == 1) {
      // Save the new PIN at the end of step 1
      newPin = controllers.map((c) => c.text).join();
    }

    step.value++;
    clearAllFields();
  }

  void handleSuccess() {
    if (pinMismatch.value) {
      Get.snackbar(
        'Error',
        'Pins do not match. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    Get.snackbar(
      'Success',
      'PIN set successfully!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    Get.to(() => DashboardView());
  }

  void clearAllFields() {
    for (var controller in controllers) {
      controller.clear();
    }
    pinMismatch.value = false;
    focusNodes[0].requestFocus();
  }

  String getStepTitle() {
    switch (step.value) {
      case 0:
        return 'Enter Current 4 digit PIN';
      case 1:
        return 'Enter New 4 digit PIN';
      default:
        return 'Re-enter the 4 digit PIN';
    }
  }

  String getStepSubtitle() {
    switch (step.value) {
      case 0:
        return 'Enter your current pin to access greytHR app';
      case 1:
        return 'Set a new PIN to securely access the greytHR app';
      default:
        return 'This PIN will be used to access the greytHR app';
    }
  }

  String getButtonText() {
    switch (step.value) {
      case 0:
        return 'Verify';
      case 1:
        return 'Next';
      default:
        return 'Confirm';
    }
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
}
