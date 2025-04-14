import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greyt_hr/app/modules/dashboard/views/dashboard_view.dart';
import '../controllers/change_password_controller.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChangePasswordController>();

    // Reset form when the page is opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.resetForm();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.home,
              color: Colors.black,
            ),
            onPressed: () {
              Get.to(() => DashboardView());
            },
          )
        ],
      ),
      body: Container(
        color: Colors.grey[50],
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Password Policy Section
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade50,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Password Policy",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      _buildValidationRow(
                        "Password should contain a minimum of 10 characters.",
                        controller.hasMinLength.value,
                        controller.isTyping.value,
                      ),
                      _buildValidationRow(
                        "Password should contain a maximum of 50 characters.",
                        controller.hasMaxLength.value,
                        controller.isTyping.value,
                      ),
                      _buildValidationRow(
                        "Password should contain uppercase, lowercase, numbers, and special characters.",
                        controller.hasValidChars.value,
                        controller.isTyping.value,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Password Fields
                _buildPasswordField(controller, "Old Password", isOldPassword: true),
                _buildPasswordField(controller, "New Password", isNewPassword: true),
                _buildPasswordField(controller, "Confirm Password", isConfirmPassword: true),

                const SizedBox(height: 20),

                // Change Password Button
                ElevatedButton(
                    onPressed: controller.isFormValid()
                        ? () => controller.submitChangePassword()
                        : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    controller.isFormValid() ? Colors.green : Colors.grey,

                  ),
                  child: const Text("Change Password"),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }

  // Password Input Field
  Widget _buildPasswordField(ChangePasswordController controller, String label,
      {bool isNewPassword = false, bool isOldPassword = false, bool isConfirmPassword = false}) {
    String? errorText = '';

    if (isOldPassword) {
      errorText = controller.currentPasswordError.value;
    } else if (isNewPassword) {
      errorText = controller.newPasswordError.value;
    } else if (isConfirmPassword) {
      errorText = controller.confirmPasswordError.value;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: isOldPassword
                ? controller.oldPasswordController
                : isNewPassword
                ? controller.newPasswordController
                : controller.confirmPasswordController,
            obscureText: isOldPassword
                ? !controller.isOldPasswordVisible.value
                : isNewPassword
                ? !controller.isPasswordVisible.value
                : !controller.isConfirmPasswordVisible.value,
            focusNode: isOldPassword
                ? controller.oldPasswordFocusNode
                : isNewPassword
                ? controller.newPasswordFocusNode
                : controller.confirmPasswordFocusNode,
            onChanged: (value) {
              if (isNewPassword) controller.validatePassword(value);
              if (isConfirmPassword) controller.validateConfirmPassword(value);
            },
            decoration: InputDecoration(
              labelText: label,
              errorText: errorText!.isNotEmpty ? errorText : null,
              suffixIcon: IconButton(
                icon: Icon(
                  isOldPassword
                      ? (controller.isOldPasswordVisible.value
                      ? Icons.visibility
                      : Icons.visibility_off)
                      : isNewPassword
                      ? (controller.isPasswordVisible.value
                      ? Icons.visibility
                      : Icons.visibility_off)
                      : (controller.isConfirmPasswordVisible.value
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
                onPressed: () {
                  if (isOldPassword) {
                    controller.isOldPasswordVisible.value =
                    !controller.isOldPasswordVisible.value;
                  } else if (isNewPassword) {
                    controller.isPasswordVisible.value =
                    !controller.isPasswordVisible.value;
                  } else {
                    controller.isConfirmPasswordVisible.value =
                    !controller.isConfirmPasswordVisible.value;
                  }
                },
              ),
            ),
          ),
        ],
      )),
    );
  }



  // Password Validation Row
  Widget _buildValidationRow(String text, bool isValid, bool isTyping) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isTyping
                ? (isValid ? Icons.check_circle : Icons.warning_amber_rounded)
                : Icons.circle_outlined,
            color: isTyping ? (isValid ? Colors.green : Colors.orange) : Colors.black,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: isTyping ? (isValid ? Colors.green : Colors.orange) : Colors.black,
              ),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
