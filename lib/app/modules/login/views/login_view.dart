import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../customloader.dart';
import '../controllers/login_controller.dart';

class LoginView extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // ✅ Soft background color
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // **GreytHR Logo**
                Image.asset(
                  'assets/images/hr_expert.png', // ✅ Correct path
                  height: 100,

                ),

                const SizedBox(height: 30),

                // **Login Card UI**
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // **Login Input Field (Employee ID or Email)**
                        TextField(
                          controller: controller.loginInputController,
                          decoration: const InputDecoration(
                            labelText: "Employee ID or Email",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Obx(() => controller.showErrors.value &&
                            controller.loginInputError.value.isNotEmpty
                            ? Text(
                          controller.loginInputError.value,
                          style: const TextStyle(color: Colors.red, fontSize: 14),
                        )
                            : const SizedBox.shrink()),

                        const SizedBox(height: 15),

                        // **Password Field**
                        TextField(
                          controller: controller.passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: "Password",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Obx(() => controller.showErrors.value &&
                            controller.passwordError.value.isNotEmpty
                            ? Text(
                          controller.passwordError.value,
                          style: const TextStyle(color: Colors.red, fontSize: 14),
                        )
                            : const SizedBox.shrink()),

                        const SizedBox(height: 30),

                        // **Login Button**
                        Obx(() => SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: controller.isLoading.value ? null : controller.login,
                            child: controller.isLoading.value
                                ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                CustomLottieMiniLoader(size: 150),
                                SizedBox(width: 10),

                              ],
                            )
                                : const Text(
                              "Login",
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        )),






                        const SizedBox(height: 15),

                        // **Forgot Password & Register**
                        Center(
                          child: Column(
                            children: [
                              TextButton(
                                onPressed: () {}, // ✅ Add Forgot Password functionality here
                                child: const Text("Forgot Password?", style: TextStyle(color: Colors.blue)),
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
