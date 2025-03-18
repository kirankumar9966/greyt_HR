import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greyt_hr/app/modules/footer/views/footer_view.dart';
import 'package:greyt_hr/app/modules/header/views/header_view.dart';
import 'package:greyt_hr/app/modules/holidayCalender/views/holiday_calender_view.dart';
import 'package:greyt_hr/app/modules/profile/views/profile_view.dart';
import 'package:greyt_hr/app/modules/settings/views/settings_view.dart';
import 'package:greyt_hr/app/modules/updates/views/updates_view.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const HeaderView(),
      endDrawer: Drawer(
        backgroundColor: Colors.white,
        elevation: 10.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Close Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(); // Close the drawer
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF607D8B), // Background color for the circle
                      ),
                      padding: const EdgeInsets.all(5), // Space around the icon
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Profile Picture and Name Section
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Color(0xFF607D8B),
                    child: Text(
                      'OK', // Example initials
                      style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Obula Kumar',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'obula@example.com',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Divider with Label
              Row(
                children: const [
                  Expanded(child: Divider(thickness: 1)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Menu',
                      style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(child: Divider(thickness: 1)),
                ],
              ),
              const SizedBox(height: 16),

              // Menu Items with Right Arrow
              ListTile(
                leading: const Icon(Icons.person, color: Colors.blue),
                title: const Text(
                  'Profile',
                  style: TextStyle(fontSize: 16),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                onTap: () {
                  Get.to(()=> ProfileView());
                },
              ),

              ListTile(
                leading: const Icon(Icons.settings, color: Colors.orange),
                title: const Text(
                  'Settings',
                  style: TextStyle(fontSize: 16),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                onTap: () {
                Get.to(() => SettingsView());
                },
              ),

              ListTile(
                leading: const Icon(Icons.system_update, color: Colors.green),
                title: const Text(
                  'Check for Updates',
                  style: TextStyle(fontSize: 16),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                onTap: () {
                  Get.to(() => UpdatesView());
                },
              ),

              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                tileColor: Colors.red.shade50, // Subtle red background for highlighting
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Rounded corners
                ),
                leading: const Icon(Icons.logout, color: Colors.red, size: 28), // Highlighted icon
                title: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red), // Bold red text
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.red), // Matching red arrow
                onTap: () {
                  // Perform Logout logic
                },
              ),
              // Spacer and Footer
              const Spacer(),
              const Divider(thickness: 1),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'App Version',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    '1.0.0',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),



      body: Container(
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Hello', // Your main text
                            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500,color: Colors.grey),
                          ),
                          TextSpan(
                            text: ' Obula ', // Your main text
                            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                          ),
                          WidgetSpan(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0), // Space between text and emoji
                              child: Text(
                                '👋', // Waving emoji
                                style: const TextStyle(fontSize: 25),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20,),
                Container(
                  height: 250, // Adjusted height for the container
                  child: Stack(
                    children: [
                      // Image occupying 40% of the container height
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 100, // Image height
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(_getImageBasedOnTime()), // Conditionally set the image
                              fit: BoxFit.cover,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                            ),
                          ),
                        ),
                      ),

                      // Blurred container at the bottom
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 190, // Height of the entire blurred section
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.black.withOpacity(0.2), // Border with light opacity
                              width: 1,
                            ),
                            color: Colors.transparent,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                color: Colors.white.withOpacity(0.2), // Semi-transparent blur background
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    // Row for the circle and text
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        // Circle with current time
                                        Container(
                                          height: 110, // Larger circle size
                                          width: 110,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [Colors.grey, Colors.blueGrey],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.black.withOpacity(0.5), // Light border
                                              width: 1,
                                            ),
                                          ),
                                          child: Center(
                                            child: Obx(
                                                  () => Text(
                                                controller.currentTime.value,
                                                textAlign: TextAlign.center,
                                                maxLines: 1, // Ensures the text stays on a single line
                                                overflow: TextOverflow.ellipsis, // Handles any overflow gracefully
                                                style: const TextStyle(
                                                  fontSize: 17, // Reduced font size
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        // Current day, shift, and date
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            const Text(
                                              'Monday | 10:00 AM To \n 07:00 PM Shift',
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Obx(() => Text(
                                              controller.currentDate.value,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.purple,
                                                  fontWeight: FontWeight.w600),
                                            )),
                                            const SizedBox(height: 18),
                                            ElevatedButton(
                                              onPressed: () {
                                                // Handle sign-out logic
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Color(0xFF607D8B),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20), // Rounded button
                                                ),
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 15,
                                                  vertical: 8,
                                                ), // Padding for button
                                              ),
                                              child: const Text(
                                                'Sign Out',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    // Sign Out button
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30,),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 320, // Adjusted height to accommodate all content
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xb80d7fE5),
                          Color(0xFF8A2BE2),
                        ],

                        begin: Alignment.topLeft, // Gradient starts from top left
                        end: Alignment.bottomRight, // Gradient ends at bottom right
                      ),
                      borderRadius: BorderRadius.circular(16), // Rounded corners
                      border: Border.all(
                        color: Colors.black.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Top Row: Heading and Arrow Icon
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Engage",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 30,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Content
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.poll, // Big Icon
                              size: 80,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              "Nothing to show!",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Create your first poll and gather your \n team's input.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                // Handle button press
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 12,
                                ),
                              ),
                              child: const Text(
                                "Create Poll",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),



                const SizedBox(height: 30,),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 400, // Adjusted height to accommodate all content
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF2196F3), // Bright blue
                          Color(0xFF90CAF9), // Light blue
                        ],

                        begin: Alignment.topLeft, // Gradient starts from top left
                        end: Alignment.bottomRight, // Gradient ends at bottom right
                      ),
                      borderRadius: BorderRadius.circular(16), // Rounded corners
                      border: Border.all(
                        color: Colors.black.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Top Row: Heading and Arrow Icon
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Payslip",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 30,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('Jan 2025', style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight:FontWeight.w400,

                            ),)
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Blurred Card
                        Container(
                          height: 200, // Adjust height for content
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2), // Blurred effect
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              // Net Pay - Top Left
                              Positioned(
                                top: 16,
                                left: 16,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Net Pay",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Obx(() => Row(
                                      children: [
                                        const Icon(Icons.currency_rupee, color: Colors.white, size: 16),
                                        Text(
                                          controller.showNetPay.value ? controller.netPay : "*****",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    )),
                                  ],
                                ),
                              ),

                              // Gross Pay - Bottom Left
                              Positioned(
                                bottom: 16,
                                left: 16,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Gross Pay",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Obx(() => Row(
                                      children: [
                                        const Icon(Icons.currency_rupee, color: Colors.white, size: 16),
                                        Text(
                                          controller.showGrossPay.value ? controller.grossPay : "*****",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    )),
                                  ],
                                ),
                              ),

                              // Deductions - Bottom Right
                              Positioned(
                                bottom: 16,
                                right: 16,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text(
                                      "Deductions",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Obx(() => Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.currency_rupee, color: Colors.white, size: 16),
                                        Text(
                                          controller.showDeductions.value ? controller.deductions : "*****",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    )),
                                  ],
                                ),
                              ),

                              // Download Icon - Top Right
                              Positioned(
                                top: 16,
                                right: 16,
                                child: GestureDetector(
                                  onTap: () {
                                    // Add download logic here
                                    print("Download clicked");
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Icon(
                                      Icons.download,
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                        ),

                        const SizedBox(height: 16),

                        // Toggle Icon for "Show Salary"
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Show Salary",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            const SizedBox(width: 8),
                            Obx(() => Switch(
                              value: controller.showNetPay.value, // Bind to the Net Pay toggle
                              onChanged: (bool value) {
                                // Toggle all fields based on switch value
                                controller.showNetPay.value = value;
                                controller.showGrossPay.value = value;
                                controller.showDeductions.value = value;
                              },
                              activeColor: Colors.white,
                              activeTrackColor: Colors.blue,
                              inactiveThumbColor: Colors.white,
                              inactiveTrackColor: Colors.grey.withOpacity(1),
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30,),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 320, // Adjusted height to accommodate all content
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFFAACA8), // Start color
                          Color(0xFFDDD6F3), // End color
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.black.withOpacity(0.1),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 12,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),



                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Top Row: Heading and Arrow Icon
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "IT Declarations",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                              size: 30,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Content
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.info_rounded, // Big Icon
                              size: 80,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 12),

                            const Text(
                              "Your IT declarations is now considered \n for May 2024.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                // Handle button press
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 12,
                                ),
                              ),
                              child: const Text(
                                "View",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30,),

                Container(

                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 4,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Upcoming Holidays",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Get.to(()=>HolidayCalenderView());
                            },
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.black87,
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      // Cards Grid
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          // Card 1
                          _modernHolidayCard(
                            icon: Icons.celebration,
                            date: "14 Mar",
                            holiday: "Holi",
                            day: "Friday",
                            gradient: [Colors.lightBlueAccent, Colors.grey],
                          ),
                          // Card 2
                          _modernHolidayCard(
                            icon: Icons.nature_people,
                            date: "01 May",
                            holiday: "Labour Day",
                            day: "Monday",
                            gradient: [Colors.lightBlueAccent, Colors.grey],
                          ),
                          // Card 3
                          _modernHolidayCard(
                            icon: Icons.flag,
                            date: "15 Aug",
                            holiday: "Independence Day",
                            day: "Tuesday",
                            gradient: [Colors.lightBlueAccent, Colors.grey],
                          ),
                          // Card 4
                          _modernHolidayCard(
                            icon: Icons.directions_boat,
                            date: "25 Dec",
                            holiday: "Christmas",
                            day: "Monday",
                            gradient: [Colors.lightBlueAccent, Colors.grey],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50,),
              ],
            ),
          ),
        ),

      ),
      bottomNavigationBar: FooterView(),
    );
  }
}



// Function to Create a Holiday Card with Gradient Design
Widget _modernHolidayCard({
  required IconData icon,
  required String date,
  required String holiday,
  required String day,
  required List<Color> gradient,
}) {
  return Container(
    width: (MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width / 2) -
        32 - // Account for padding
        8, // Spacing
    height: 245, // Fixed height for the card
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: gradient,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          spreadRadius: 2,
          blurRadius: 6,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Icon
        Icon(
          icon,
          size: 50,
          color: Colors.white,
        ),
        const SizedBox(height: 12),
        // Date
        Text(
          date,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        // Holiday Name
        Text(
          holiday,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        // Day
        Text(
          day,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
      ],
    ),
  );
}

String _getImageBasedOnTime() {
  final int hour = DateTime.now().hour;

  if (hour >= 5 && hour < 12) {
    // Morning (5:00 AM - 11:59 AM)
    return 'assets/images/Morning sun.jpg';
  } else if (hour >= 12 && hour < 17) {
    // Afternoon (12:00 PM - 4:59 PM)
    return 'assets/images/Home.avif';
  } else if (hour >= 17 && hour < 20) {
    // Evening (5:00 PM - 7:59 PM)
    return 'assets/images/Morning sunrise.avif';
  } else {
    // Night (8:00 PM - 4:59 AM)
    return 'assets/images/Night moon.avif';
  }
}