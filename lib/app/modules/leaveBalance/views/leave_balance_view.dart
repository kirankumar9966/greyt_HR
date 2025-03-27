import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greyt_hr/app/modules/casualLeave/views/casual_leave_view.dart';
import '../controllers/leave_balance_controller.dart';

class LeaveBalanceView extends GetView<LeaveBalanceController> {
  const LeaveBalanceView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LeaveBalanceController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Leave Balance',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Container(
        color: Colors.grey[50],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dropdown and Toggle Switch
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                        () => DropdownButton<String>(
                      value: controller.selectedDateRange.value,
                      items: controller.dateRanges
                          .map((range) => DropdownMenuItem(
                        value: range,
                        child: Text(range),
                      ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          controller.selectedDateRange.value = value;
                        }
                      },
                    ),
                  ),
                  Row(
                    children: [
                      const Text("Show All"),
                      Obx(
                            () => Switch(
                          value: controller.showAll.value,
                          onChanged: (value) {
                            controller.showAll.value = value;
                          },
                          activeColor: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Leave Cards
              Expanded(
                child: Obx(
                      () {
                    // Filter leave data based on the "Show All" toggle
                    final filteredLeaveData = controller.showAll.value
                        ? controller.leaveData
                        : controller.leaveData
                        .where((leave) =>
                    double.parse(leave["balance"].toString()) > 0)
                        .toList();

                    // Show a message if no leaves are available
                    if (filteredLeaveData.isEmpty) {
                      return const Center(
                        child: Text(
                          "No leaves available.",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      );
                    }

                    // Render leave cards
                    return ListView.builder(
                      itemCount: filteredLeaveData.length,
                      itemBuilder: (context, index) {
                        final leave = filteredLeaveData[index];
                        return GestureDetector(
                          onTap: () {
                            _navigateToLeaveDetail(leave["title"]!);
                          },
                          child: _buildLeaveCard(
                            context,
                            title: leave["title"]!,
                            balance: leave["balance"].toString(),
                            granted: leave["granted"]!,
                            consumed: leave["consumed"]!,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Navigation logic based on leave type
  void _navigateToLeaveDetail(String leaveType) {
    switch (leaveType) {
      case "Casual Leave":
        Get.to(() => const CasualLeaveView()); // Navigate to Casual Leave view
        break;
      case "Sick Leave":
        // Get.to(() => const SickLeaveView()); // Navigate to Sick Leave view
        break;
      case "Annual Leave":
        // Get.to(() => const AnnualLeaveView()); // Navigate to Annual Leave view
        break;
      default:
        Get.snackbar("Error", "View not available for this leave type.");
    }
  }

  // Helper method to build leave cards
  Widget _buildLeaveCard(
      BuildContext context, {
        required String title,
        required String balance,
        required String granted,
        required String consumed,
      }) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blueGrey, width: 1),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                Text(
                  "$granted, $consumed",
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  balance,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: balance == "0.0" ? Colors.red : Colors.blue,
                  ),
                ),
                const Text("Bal."),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
