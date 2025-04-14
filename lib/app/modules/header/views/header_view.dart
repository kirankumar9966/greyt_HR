import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/header_controller.dart';


class HeaderView extends GetView<HeaderController> implements PreferredSizeWidget {
  const HeaderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());
    return Column(
      children: [
        // AppBar Section
        AppBar(
          automaticallyImplyLeading: false, // Prevents the back arrow from appearing
          backgroundColor: Colors.white,
          // elevation: 30.0,
          scrolledUnderElevation: 0,
          toolbarHeight: 80,
          actions: [Container()], // Remove the default trailing icon
          title: Row(
            children: [
              // App Logo aligned to the left
              Image.asset(
                'assets/images/Xsilica.png',
                width: 100,
                height: 70,
                fit: BoxFit.fill,
              ),

              // Spacer to push profile to the right
              const Spacer(),

              // Profile Section with Sidebar Toggle
              GestureDetector(
                onTap: () {
                  Scaffold.of(context).openEndDrawer(); // Open the sidebar
                },

                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Obx(() {
                      final employee = profileController.employee.value;

                      if (employee == null) {
                        return const Text("Failed to load profile");
                      }
                      // Dynamically generate initials
                      final initials = "${employee.firstName.isNotEmpty ? employee.firstName[0] : ''}"
                          "${employee.lastName.isNotEmpty ? employee.lastName[0] : ''}";
                      final hasImage = employee.image.isNotEmpty;
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            child: Builder(
                              builder: (context) {
                                try {
                                  if (hasImage) {
                                    final imageBytes = base64Decode(employee.image);
                                    return CircleAvatar(
                                      radius: 28,
                                      backgroundImage: MemoryImage(imageBytes),
                                    );
                                  } else {
                                    throw Exception("No image found");
                                  }
                                } catch (e) {
                                  // If decoding fails or image is broken
                                  final initials = "${employee.firstName[0]}${employee.lastName[0]}";
                                  return Text(
                                    initials.toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF607D8B),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          // You can add additional widgets here if needed.
                        ],
                      );
                    }),
                  )


              ),
              ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}