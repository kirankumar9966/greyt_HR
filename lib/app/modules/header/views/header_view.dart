import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/header_controller.dart';


class HeaderView extends GetView<HeaderController> implements PreferredSizeWidget {
  const HeaderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                child: Obx(() => CircleAvatar(
                  radius: 20,
                  backgroundColor: Color(0xFF607D8B),
                  child: Text(
                    controller.userInitials.value,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                )),
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