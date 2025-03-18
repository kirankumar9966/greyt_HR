import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greyt_hr/app/modules/dashboard/views/dashboard_view.dart';
import 'package:greyt_hr/app/modules/resign/views/resign_view.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Get.to(() => DashboardView());
            },
          ),
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Column(
        children: [
          // Header section
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey, Colors.blueGrey],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Profile Avatar
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Obx(() {
                    final initials = controller.employeeName.value
                        .split(' ')
                        .map((e) => e[0])
                        .join(); // Extract initials
                    return Text(
                      initials,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF607D8B),// A lighter shade of blue-grey
                    ),
                    );
                  }),
                ),
                const SizedBox(height: 15),
                // Name
                Obx(() => Text(
                  controller.employeeName.value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )),
                const SizedBox(height: 8),
                // ID
                Obx(() => Text(
                  controller.employeeID.value,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500
                  ),
                )),
              ],
            ),
          ),
          // Profile details section
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              color: Colors.grey[100],
              child: Column(
                children: [
                  buildProfileDetailCard(
                    icon: Icons.phone,
                    title: "Extension No",
                    value: controller.extensionNo.value,
                  ),
                  buildProfileDetailCard(
                    icon: Icons.location_on,
                    title: "Location",
                    value: controller.location.value,
                  ),
                  buildProfileDetailCard(
                    icon: Icons.calendar_today,
                    title: "Joining Date",
                    value: controller.joiningDate.value,
                  ),
                  buildProfileDetailCard(
                    icon: Icons.cake,
                    title: "Date Of Birth",
                    value: controller.dateOfBirth.value,
                  ),
                  const Spacer(),
                  // Resign button
                  buildResignButton(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to build a single card for profile details
  Widget buildProfileDetailCard({required IconData icon, required String title, required String value}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        child: Row(
          children: [
            Icon(icon, size: 25, color: Colors.blueGrey.shade500),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Resign button
  Widget buildResignButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
       Get.to( ()=>ResignView() );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Resign",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

}
