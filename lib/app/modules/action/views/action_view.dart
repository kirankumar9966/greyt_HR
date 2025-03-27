import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greyt_hr/app/modules/attendanceInfo/views/attendance_info_view.dart';
import 'package:greyt_hr/app/modules/footer/views/footer_view.dart';
import 'package:greyt_hr/app/modules/leaveBalance/views/leave_balance_view.dart';
import 'package:greyt_hr/app/modules/payslips/views/payslips_view.dart';
import 'package:greyt_hr/app/modules/settings/views/settings_view.dart';

import '../controllers/action_controller.dart';

// Importing the different views you created


class ActionView extends GetView<ActionController> {
  const ActionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actions',style: TextStyle(color: Colors.white),),
        backgroundColor:  Color(0xFF607D8B),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
        ),
      ),
      body: Container(
        color: Colors.grey[50],
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Action item widgets
              _buildActionItem(
                Icons.check_box,
                Colors.blue,
                "Apply Regularization",
                SettingsView(), // Navigation to ApplyRegularizationView
              ),
              _buildActionItem(
                Icons.info,
                Colors.blue,
                "Attendance Info",
                AttendanceInfoView(), // Navigation to AttendanceInfoView
              ),
              _buildActionItem(
                Icons.coffee,
                Colors.green,
                "Apply Leave",
                SettingsView(), // Navigation to ApplyLeaveView
              ),
              _buildActionItem(
                Icons.balance,
                Colors.green,
                "Leave Balance",
                LeaveBalanceView(), // Navigation to LeaveBalanceView
              ),
              _buildActionItem(
                Icons.calendar_month,
                Colors.green,
                "Holiday Calendar",
                SettingsView(), // Navigation to HolidayCalendarView
              ),
              _buildActionItem(
                Icons.note,
                Colors.purple,
                "Payslips",
                PayslipsView(), // Navigation to PayslipsView
              ),
              _buildActionItem(
                Icons.trending_up,
                Colors.purple,
                "YTD Reports",
                SettingsView(), // Navigation to YTDReportsView
              ),
              _buildActionItem(
                Icons.computer,
                Colors.purple,
                "IT Statement",
                SettingsView(), // Navigation to ITStatementView
              ),
              _buildActionItem(
                Icons.link,
                Colors.orange,
                "Quick Links",
                SettingsView(), // Navigation to QuickLinksView
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: FooterView(),
    );
  }

  // Function to build action items
  Widget _buildActionItem(IconData icon, Color color, String title, Widget destination) {
    return GestureDetector(
      onTap: () {
        // Use GetX navigation to go to the corresponding view
        Get.to(destination);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.shade100,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Icon with background
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                size: 28,
                color: color,
              ),
            ),
            const SizedBox(width: 15),
            // Title text
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            // Optional: Add an icon at the end (if needed)
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
