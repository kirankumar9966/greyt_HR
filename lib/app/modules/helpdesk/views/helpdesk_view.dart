import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/helpdesk_controller.dart';


class HelpdeskView extends GetView<HelpdeskController> {
  const HelpdeskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Helpdesk", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        bottom: TabBar(
          controller: controller.tabController,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: "Apply"),
            Tab(text: "Pending"),
            Tab(text: "History"),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: [
          /// ✅ APPLY TAB: Actual form UI from controller
          controller.buildApplyForm(),

          /// ✅ PENDING TAB
          Obx(() => ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: controller.pendingRequests.length,
            itemBuilder: (context, index) {
              final item = controller.pendingRequests[index];
              return _buildRequestCard(item, context);
            },
          )),

          /// ✅ HISTORY TAB
          Obx(() => ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: controller.historyRequests.length,
            itemBuilder: (context, index) {
              final item = controller.historyRequests[index];
              return _buildRequestCard(item, context);
            },
          )),
        ],
      ),
    );
  }

  /// 🔷 Common Request Card Widget
  Widget _buildRequestCard(Map<String, String> item, BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Category
            Text(item['category'] ?? '',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),

            const SizedBox(height: 6),

            /// Assigned person + Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(item['assigned'] ?? '', style: TextStyle(fontSize: 14)),
                Text(item['date'] ?? '', style: TextStyle(color: Colors.grey)),
              ],
            ),

            const SizedBox(height: 6),

            /// Subject
            Text("Request for ${item['subject'] ?? ''}"),

            /// Priority
            Text(item['priority'] ?? '', style: TextStyle(color: Colors.red)),

            const SizedBox(height: 12),

            /// Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {
                    controller.openDetails(context, item);
                  },
                  child: const Text("View More"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text("Withdraw"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
