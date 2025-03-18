import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:greyt_hr/app/modules/dashboard/views/dashboard_view.dart';

import '../controllers/about_this_app_controller.dart';

class AboutThisAppView extends GetView<AboutThisAppController> {
  const AboutThisAppView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About This App"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Get.to(() => DashboardView());
            },
          ),
        ],
        foregroundColor: Colors.black,
      ),
        body: Container(
          color: Colors.grey[50],
          alignment: Alignment.topCenter, // Aligns content to the top-center
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "greytHR",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "version 6.7.7",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 30),
              Image.asset(
                'assets/images/greytHR.avif',
                height: 250,
                width: 250,
              ),
              const SizedBox(height: 30),

              GestureDetector(
                onTap: () {
                  Get.to(()=>AboutThisAppView());
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
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
                          borderRadius: BorderRadius.circular(8), // Rounded corners
                        ),
                        child: Icon(
                          Icons.lock,
                          size: 24,
                          color: Colors.blueGrey.shade700,
                        ),
                      ),
                      const SizedBox(width: 15),
                      // Heading
                      Expanded(
                        child: Text(
                          "Privacy Policy",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
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
              // Privacy Policy
              GestureDetector(
                onTap: () {
                  // Navigation logic for "Privacy Policy"
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
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
                          borderRadius: BorderRadius.circular(8), // Rounded corners
                        ),
                        child: Icon(
                          Icons.note,
                          size: 24,
                          color: Colors.blueGrey.shade700,
                        ),
                      ),
                      const SizedBox(width: 15),
                      // Heading
                      Expanded(
                        child: Text(
                          "Terms of Services",
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


    );
  }
}
