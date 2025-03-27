import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSuccessFlash(String message) {
  Get.snackbar(
    "Success",
    message,
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.green.withOpacity(0.9),
    colorText: Colors.white,
    margin: const EdgeInsets.all(12),
    borderRadius: 10,
    duration: const Duration(seconds: 2),
    icon: const Icon(Icons.check_circle, color: Colors.white),
  );
}
