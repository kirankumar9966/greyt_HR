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
String getInitials(String name) {
  final parts = name.trim().split(' ');
  if (parts.length >= 2) {
    return "${parts[0][0]}${parts[1][0]}".toUpperCase();
  } else if (parts.isNotEmpty && parts[0].isNotEmpty) {
    return parts[0][0].toUpperCase();
  }
  return "?";
}
Widget _buildInitialsAvatar(String initials) {
  return Center(
    child: Text(
      initials,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.pink,
      ),
    ),
  );
}

