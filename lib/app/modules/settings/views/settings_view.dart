import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:greyt_hr/app/modules/aboutThisApp/views/about_this_app_view.dart';
import 'package:greyt_hr/app/modules/dashboard/views/dashboard_view.dart';
import 'package:greyt_hr/app/modules/privacyAndSecurity/views/privacy_and_security_view.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading:IconButton(
          icon:const  Icon(Icons.arrow_back),
            onPressed: (){
            Navigator.pop(context);
            }),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              icon: const Icon(Icons.home),
              onPressed: (){
               Get.to(()=>DashboardView());
              })
        ],

      ),
      body: Container(
        color: Colors.grey[50],
        child: Padding(
          padding: const EdgeInsets.all(10.0),

          child: Column(
            children: [
              // About this App
              const SizedBox(height: 15,),
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
                          Icons.info,
                          size: 24,
                          color: Colors.blueGrey.shade700,
                        ),
                      ),
                      const SizedBox(width: 15),
                      // Heading
                      Expanded(
                        child: Text(
                          "About this App",
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
                 Get.to(()=>PrivacyAndSecurityView());
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
                          Icons.privacy_tip,
                          size: 24,
                          color: Colors.blueGrey.shade700,
                        ),
                      ),
                      const SizedBox(width: 15),
                      // Heading
                      Expanded(
                        child: Text(
                          "Privacy & Security",
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
