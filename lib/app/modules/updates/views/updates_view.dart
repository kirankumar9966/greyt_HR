import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/updates_controller.dart';

class UpdatesView extends GetView<UpdatesController> {
  const UpdatesView({super.key});

  void showUpdateModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white, // Pure white modal
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Row(
                  children: [
                    IconButton(
                        icon: const Icon(Icons.cancel, color: Color(0xFF607D8B)),
                        onPressed: () {}
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        "No Update Available",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis, // Adds ellipsis if text is too long
                      ),
                    ),
                  ],
                ),


                const Text(
                  "Hurrah!Your app is upto date.🎉",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12,color: Colors.black),
                ),
                const SizedBox(height: 20),
                // Big Image
                Image.asset(
                  'assets/images/No update.jpg', // Replace with your image path
                  height: 200,
                  width: 250,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 16),

                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:Color(0xFF607D8B),
                    foregroundColor: Colors.white, // Set text color
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Add padding if needed
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Rounded corners
                    ),
                  ),
                  child: const Text(
                    "Ok, Got It",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Customize text style
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fullscreen background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/Modal bcnd.jpg', // Update with your background image path
              fit: BoxFit.cover,
            ),
          ),
          // Vibrant blurred overlay
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15), // Vibrant blur effect
              child: Container(
                color: Colors.white.withOpacity(0.2), // Slight dark overlay
              ),
            ),
          ),
          // Main Content
          Obx(() {
            if (!controller.isUpdateAvailable.value) {
              // Show modal directly
              Future.delayed(Duration.zero, () => showUpdateModal(context));
            }
            return const Center(
              child: Text(
                "System Updates",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            );
          }),
        ],
      ),
    );
  }
}
