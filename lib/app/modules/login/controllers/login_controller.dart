import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth_service.dart';
import '../../profile/controllers/profile_controller.dart';


class LoginController extends GetxController {
  final TextEditingController loginInputController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var isLoading = false.obs;
  var showErrors = false.obs;
  var loginInputError = ''.obs;
  var passwordError = ''.obs;

  void login() async {
    showErrors.value = true;
    final loginInput = loginInputController.text.trim();
    final password = passwordController.text.trim();

    if (loginInput.isEmpty) {
      loginInputError.value = "Employee ID or Email is required";
    } else {
      loginInputError.value = "";
    }

    passwordError.value = password.isEmpty ? "Password is required" : "";

    if (loginInputError.isNotEmpty || passwordError.isNotEmpty) return;

    // Clean up previous session
    if (Get.isRegistered<ProfileController>()) {
      Get.delete<ProfileController>();
    }

    await AuthService.logout(); // clear old storage

    isLoading(true);
    final response = await AuthService.login(loginInput, password);
    isLoading(false);

    if (response["status"] == "success") {
      // ✅ Add a slight delay to ensure token is written before proceeding
      await Future.delayed(const Duration(milliseconds: 200));

      final token = AuthService.getToken();
      if (token != null && token.isNotEmpty) {
        Get.offAllNamed(Routes.DASHBOARD);
      } else {
        Future.delayed(Duration.zero, () {
          Get.snackbar("Error", "Token not available after login");
        });
      }
    } else {
      Future.delayed(Duration.zero, () {
        Get.snackbar("Login Failed", response["message"], snackPosition: SnackPosition.BOTTOM);
      });
    }
  }

  Future<void> logout() async {
    await AuthService.logout();
  }
}
