import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greyt_hr/app/modules/action/views/action_view.dart';
import 'package:greyt_hr/app/modules/dashboard/views/dashboard_view.dart';
import 'package:greyt_hr/app/modules/explore/views/explore_view.dart';
import 'package:greyt_hr/app/modules/privacyAndSecurity/views/privacy_and_security_view.dart';
import 'package:greyt_hr/app/modules/settings/views/settings_view.dart';
import '../controllers/footer_controller.dart';

class FooterView extends GetView<FooterController> {
  const FooterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => BottomNavigationBar(
      currentIndex: controller.selectedIndex.value,
      onTap: (index) {
        controller.updateIndex(index);
        switch (index) {
          case 0:
            Get.offAll(() => DashboardView()); // Replaces navigation stack
            break;
          case 1:
            Get.to(() => ActionView()); // Push to scanner view
            break;
          case 2:
            Get.to(() => ExploreView()); // Push to history view
            break;
          case 3:
            Get.to(() => SettingsView()); // Push to history view
            break;
        }
      },
      backgroundColor: Colors.white, // Background color
      selectedItemColor: Colors.blue, // Highlighted icon color
      unselectedItemColor: Colors.grey, // Non-selected icons color
      showSelectedLabels: true,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed, // Prevents shifting effect
      elevation: 8, // Adds shadow effect
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.call_to_action),
          label: 'Action',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_activity),
          label: 'Engage',
        ),
      ],
    ));
  }
}
