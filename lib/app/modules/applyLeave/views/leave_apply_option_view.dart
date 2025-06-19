// leave_apply_options_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaveApplyOptionsView extends StatelessWidget {
  const LeaveApplyOptionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apply'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildOption(
            context,
            image: 'assets/images/leave.png',
            label: 'Leave',
            onTap: () {
              // Navigate to Leave Type screen
              Get.toNamed('/leave-types');
            },
          ),
          _buildOption(
            context,
            image: 'assets/images/restricted_holiday.png',
            label: 'Restricted Holiday',
            onTap: () {
              Get.toNamed('/restricted-holiday');
            },
          ),
          _buildOption(
            context,
            image: 'assets/images/comp_off.png',
            label: 'Comp Off Grant',
            onTap: () {
              Get.toNamed('/comp-off');
            },
          ),
          _buildOption(
            context,
            image: 'assets/images/leave_cancel.png',
            label: 'Leave Cancel',
            onTap: () {
              Get.toNamed('/leave-cancel');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOption(BuildContext context,
      {required String image, required String label, required VoidCallback onTap}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Image.asset(image, height: 40),
        title: Text(label),
        trailing: const Icon(Icons.arrow_forward),
        onTap: onTap,
      ),
    );
  }
}
