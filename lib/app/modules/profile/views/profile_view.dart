import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greyt_hr/app/modules/dashboard/views/dashboard_view.dart';
import 'package:greyt_hr/app/modules/resign/views/resign_view.dart';
import '../controllers/profile_controller.dart';
import 'package:intl/intl.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController()); // Ensure controller is initialized

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => Get.to(() => const DashboardView()),
          ),
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final employee = controller.employee.value;

        if (employee == null) {
          return const Center(child: Text("No profile data available"));
        }

        final hasImage = employee.image.isNotEmpty;

        return Column(
          children: [
            // Header section with avatar and name
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
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Builder(
                      builder: (context) {
                        try {
                          if (hasImage) {
                            final imageBytes = base64Decode(employee.image);
                            return CircleAvatar(
                              radius: 38,
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

                  const SizedBox(height: 15),
                  Text(
                    "${employee.firstName} ${employee.lastName}",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    employee.empId,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // Profile details
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                color: Colors.grey[100],
                child: ListView(
                  children: [
                    buildProfileDetailCard(
                      icon: Icons.email,
                      title: "Email",
                      value: employee.email,
                    ),
                    buildProfileDetailCard(
                      icon: Icons.work,
                      title: "Job Role",
                      value: employee.jobRole,
                    ),
                    buildProfileDetailCard(
                      icon: Icons.location_on,
                      title: "Location",
                      value: employee.jobLocation,
                    ),
                    buildProfileDetailCard(
                      icon: Icons.male,
                      title: "Gender",
                      value: employee.gender,
                    ),

                    buildProfileDetailCard(
                      icon: Icons.calendar_today,
                      title: "Joining Date",
                      value: formatDate(employee.hireDate),
                    ),


                    const SizedBox(height: 20),
                    buildResignButton(),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget buildProfileDetailCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        child: Row(
          children: [
            Icon(icon, size: 25, color: Colors.blueGrey.shade500),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
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
            ),
          ],
        ),
      ),
    );
  }

  Widget buildResignButton() {
    return GestureDetector(
      onTap: () => Get.to(() => const ResignView()),
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
          children: const [
            Text(
              "Resign",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            Icon(
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
String formatDate(String dateStr) {
  try {
    final date = DateTime.parse(dateStr);
    return DateFormat('dd-MM-yyyy').format(date);
  } catch (e) {
    return dateStr; // fallback to original if parsing fails
  }
}
