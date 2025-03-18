import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greyt_hr/app/modules/changePassword/views/change_password_view.dart';
import 'package:greyt_hr/app/modules/dashboard/views/dashboard_view.dart';
import 'package:greyt_hr/app/modules/newPinSetup/views/new_pin_setup_view.dart';

import '../controllers/privacy_and_security_controller.dart';

class PrivacyAndSecurityView extends GetView<PrivacyAndSecurityController> {
  const PrivacyAndSecurityView({super.key});

  @override
  Widget build(BuildContext context) {
    // Use a StatefulWidget or RxBool for managing the expanded state

    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy & Security'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.isAppLockExpanded.value =
                        !controller.isAppLockExpanded.value;
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.white, // Background color for container
                          borderRadius:  const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ), // Rounded corners
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueGrey.shade50,
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Icon with background
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.blueGrey.shade100, // Background color
                                borderRadius: BorderRadius.circular(8), // Rounded corners
                              ),
                              child: Icon(
                                Icons.key,
                                size: 24,
                                color: Colors.blueGrey.shade700,
                              ),
                            ),
                            const SizedBox(width: 15),
                            // Heading
                            Expanded(
                              child: Text(
                                "App Lock",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey.shade800,
                                ),
                              ),
                            ),
                            // Dropdown icon changes based on expanded state
                            Icon(
                              controller.isAppLockExpanded.value
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                              size: 20,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Expanded content for App Lock
                    if (controller.isAppLockExpanded.value)
                    Obx(() {
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueGrey.shade50,
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Biometric App Lock",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blueGrey.shade700,
                                  ),
                                ),

                                Transform.scale(
                                  scale: 0.8, // Adjust the scale factor (e.g., 1.0 is default size, 1.5 is 50% larger)
                                  child: Switch(
                                    value: controller.isBiometricEnabled.value,
                                    onChanged: (value) {
                                      if (value) {
                                        // Enable biometric authentication
                                        controller.toggleBiometric();
                                      } else {
                                        // Disable biometric authentication
                                        controller.isBiometricEnabled.value = false;
                                      }
                                    },
                                    activeColor: Colors.lightGreenAccent, // Color of the thumb when switch is ON
                                    activeTrackColor: Colors.green, // Color of the track when switch is ON
                                    inactiveThumbColor: Colors.grey, // Color of the thumb when switch is OFF
                                    inactiveTrackColor: Colors.grey.shade300, // Color of the track when switch is OFF
                                  ),
                                ),

                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Fingerprint/Face ID will be used for app lock. Please grant permission to the app to access biometrics from your account.",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.blueGrey.shade400,
                                fontWeight: FontWeight.w500
                              ),
                            ),


                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (controller.isPinEnabled.value) {
                                        // Navigate to Edit PIN View
                                        Get.to(() => DashboardView());
                                      } else {
                                        // Navigate to New PIN Setup View
                                        Get.to(() => NewPinSetupView());
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        Obx(() => Text(
                                          controller.isPinEnabled.value
                                              ? 'Edit 4 Digit PIN'
                                              : 'Enable 4 Digit PIN',
                                          style: TextStyle(
                                            color: Colors.blueGrey.shade700,
                                            fontSize: 16,
                                          ),
                                        )),
                                        const Spacer(),
                                        const Icon(Icons.arrow_forward_ios, size: 16),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),


                          ],
                        ),
                      );
                    }),
                  ],
                );
              }),

              const SizedBox(height: 10,),

              GestureDetector(
                onTap: () {
                  Get.to(() => ChangePasswordView());
                },
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
                  margin: const EdgeInsets.only(bottom: 16), // Gap between containers
                  decoration: BoxDecoration(
                    color: Colors.white, // Background color for container
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueGrey.shade50,
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Icon with background
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey.shade100, // Background color
                          borderRadius:
                          BorderRadius.circular(8), // Rounded corners
                        ),
                        child: Icon(
                          Icons.settings,
                          size: 24,
                          color: Colors.blueGrey.shade700,
                        ),
                      ),
                      const SizedBox(width: 15),
                      // Heading
                      Expanded(
                        child: Text(
                          "Change Password",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey.shade800,
                          ),
                        ),
                      ),
                      // Right arrow
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
