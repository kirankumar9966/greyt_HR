import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../services/change_password_service.dart';

class ChangePasswordController extends GetxController {
  // Use TextEditingController
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  // Focus Nodes
  FocusNode oldPasswordFocusNode = FocusNode();
  FocusNode newPasswordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  // Reactive variables for validation
  var hasMinLength = false.obs;
  var hasMaxLength = true.obs;
  var hasValidChars = false.obs;
  var isTyping = false.obs;
  var isConfirmPasswordValid = false.obs;

  // Password visibility states
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;
  var isOldPasswordVisible = false.obs;

  var currentPasswordError = ''.obs;
  var newPasswordError = ''.obs;
  var confirmPasswordError = ''.obs;

  void submitChangePassword() async {
    final current = oldPasswordController.text.trim();
    final newPass = newPasswordController.text.trim();
    final confirm = confirmPasswordController.text.trim();

    // Reset all errors
    currentPasswordError.value = '';
    newPasswordError.value = '';
    confirmPasswordError.value = '';

    final response = await ChangePasswordService.changePassword(
      currentPassword: current,
      newPassword: newPass,
      confirmPassword: confirm,
    );

    if (response['status'] == 'success') {
      Get.back();
      Fluttertoast.showToast(
        msg: response['message'] ?? "Password updated successfully",
        backgroundColor: Colors.green,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } else {
      final message = response['message'] ?? '';
      // Map specific messages to fields
      if (message.contains("Current password is incorrect")) {
        currentPasswordError.value = message;
      } else if (message.contains("New password cannot be the same")) {
        newPasswordError.value = message;
      } else if (message.contains("do not match")) {
        confirmPasswordError.value = message;
      } else {
        // fallback for unknown errors
        Fluttertoast.showToast(
          msg: message,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    }
  }


  @override
  void onInit() {
    super.onInit();
    resetForm();
  }

  @override
  void onClose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    oldPasswordFocusNode.dispose();
    newPasswordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    super.onClose();
  }

  // Password Validation
  void validatePassword(String value) {
    isTyping.value = value.isNotEmpty;
    hasMinLength.value = value.length >= 10;
    hasMaxLength.value = value.length <= 50;
    hasValidChars.value = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&(),.^#])[A-Za-z\d@$!%*?&(),.^#]+$')
        .hasMatch(value);
    validateConfirmPassword(confirmPasswordController.text);
  }

  void validateConfirmPassword(String value) {
    isTyping.value = true;
    isConfirmPasswordValid.value = value == newPasswordController.text;
  }

  bool isFormValid() {
    return oldPasswordController.text.isNotEmpty &&
        hasMinLength.value &&
        hasMaxLength.value &&
        hasValidChars.value &&
        isConfirmPasswordValid.value;
  }

  // Reset Form when opening ChangePasswordView
  void resetForm() {
    oldPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();

    hasMinLength.value = false;
    hasMaxLength.value = true;
    hasValidChars.value = false;
    isTyping.value = false;
    isConfirmPasswordValid.value = false;

    isPasswordVisible.value = false;
    isConfirmPasswordVisible.value = false;
    isOldPasswordVisible.value = false;
  }
}
