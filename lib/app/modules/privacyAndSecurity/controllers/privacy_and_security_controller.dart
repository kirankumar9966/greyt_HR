import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class PrivacyAndSecurityController extends GetxController {
  //TODO: Implement PrivacyAndSecurityController

  final RxBool isAppLockExpanded = false.obs;
  var isBiometricEnabled =false.obs;
  final LocalAuthentication _auth = LocalAuthentication();
  var isPinEnabled = false.obs;
  final count = 0.obs;

  bool isPinComplete() {
    // Implement logic to check if PIN is complete
    return true; // Example
  }

  void savePin() {
    // Logic to save the PIN securely
  }

  void enablePin() {
    print("PIN enabled via PrivacyAndSecurityController");
  }

  Future<void> toggleBiometric() async {
    try {
      // Check if the device supports biometrics
      bool isSupported = await _auth.isDeviceSupported(); // Check if supported
      if (!isSupported) {
        Get.snackbar("Error", "Biometric authentication is not supported on this device.");
        return;
      }

      bool canCheckBiometrics = await _auth.canCheckBiometrics; // Check biometrics availability
      if (!canCheckBiometrics) {
        Get.snackbar("Error", "Biometric hardware is unavailable or not configured.");
        return;
      }

      // Request biometric authentication
      bool didAuthenticate = await _auth.authenticate(
        localizedReason: 'Please authenticate to enable biometric app lock',
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
      );

      if (didAuthenticate) {
        isBiometricEnabled.value = true;
        Get.snackbar("Success", "Biometric authentication enabled!");
      } else {
        isBiometricEnabled.value = false;
        Get.snackbar("Failed", "Authentication failed. Try again.");
      }
    } catch (e) {
      // Show error message
      Get.snackbar("Error", "An error occurred: ${e.toString()}");
    }
  }

  void disablePin() {
    isPinEnabled.value = false; // Disable the PIN
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
    super.onClose();
  }

  void increment() => count.value++;
}
