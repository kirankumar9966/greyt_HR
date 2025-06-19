// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/apply_leave_controller.dart';
//
//
// class  ApplyLeaveView extends GetView< ApplyLeaveController> {
//   const ApplyLeaveView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Leave', style: TextStyle(color: Colors.black)),
//           leading: const BackButton(color: Colors.black),
//           backgroundColor: Colors.white,
//           elevation: 0,
//           bottom: const TabBar(
//             tabs: [
//               Tab(text: 'Pending'),
//               Tab(text: 'History'),
//             ],
//             labelColor: Colors.black,
//             indicatorColor: Colors.blue,
//           ),
//         ),
//         body: Column(
//           children: [
//             Container(
//               margin: const EdgeInsets.all(16),
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: Colors.grey.shade300),
//                 boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 4)],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Row(
//                     children: [
//                       Icon(Icons.card_travel, size: 32),
//                       SizedBox(width: 8),
//                       Text('Apply for Leaves', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                     ],
//                   ),
//                   const SizedBox(height: 8),
//                   const Text('Account for your absence by managing leaves.'),
//                   const SizedBox(height: 12),
//                   Center(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Get.bottomSheet(
//                           Container(
//                             padding: const EdgeInsets.all(16),
//                             decoration: const BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//                             ),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 _buildApplyItem('Leave', Icons.card_travel),
//                                 _buildApplyItem('Restricted Holiday', Icons.calendar_today),
//                                 _buildApplyItem('Comp Off Grant', Icons.access_time),
//                                 _buildApplyItem('Leave Cancel', Icons.cancel),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue,
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//                         minimumSize: const Size.fromHeight(45),
//                       ),
//                       child: const Text('Apply Now'),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: TabBarView(
//                 children: [
//                   Obx(() {
//                     final pending = controller.pendingLeaves;
//                     if (pending.isEmpty) {
//                       return _buildEmptyState('Your pending leave requests will appear here.');
//                     }
//                     return ListView.builder(
//                       itemCount: pending.length,
//                       itemBuilder: (context, index) {
//                         final leave = pending[index];
//                         return _buildLeaveCard(leave);
//                       },
//                     );
//                   }),
//                   Obx(() {
//                     final history = controller.historyLeaves;
//                     if (history.isEmpty) {
//                       return _buildEmptyState('Your leave history will appear here.');
//                     }
//                     return ListView.builder(
//                       itemCount: history.length,
//                       itemBuilder: (context, index) {
//                         final leave = history[index];
//                         return _buildLeaveCard(leave);
//                       },
//                     );
//                   }),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildApplyItem(String label, IconData icon) {
//     return ListTile(
//       leading: Icon(icon, color: Colors.teal),
//       title: Text(label),
//       trailing: const Icon(Icons.arrow_forward),
//       onTap: () => Get.back(), // simulate navigation
//     );
//   }
//
//   Widget _buildEmptyState(String message) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(Icons.inbox, size: 80, color: Colors.grey),
//           const SizedBox(height: 16),
//           const Text('It’s empty here!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//           const SizedBox(height: 8),
//           Text(message, style: const TextStyle(color: Colors.grey)),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLeaveCard(Map<String, dynamic> leave) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade100,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             '${leave['type'] ?? ''} - ${leave['days'] ?? ''} day(s)',
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 4),
//           Row(
//             children: [
//               const Icon(Icons.folder, size: 16),
//               const SizedBox(width: 4),
//               Text('Category: ${leave['type'] ?? ''}'),
//               const Spacer(),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: leave['status'] == 'Approved' ? Colors.green.shade100 : Colors.orange.shade100,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Text(
//                   leave['status'] ?? '',
//                   style: TextStyle(
//                     color: leave['status'] == 'Approved' ? Colors.green : Colors.orange,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 4),
//           Row(
//             children: [
//               const Icon(Icons.date_range, size: 16),
//               const SizedBox(width: 4),
//               Text('Applied On: ${leave['appliedDate'] ?? ''}'),
//             ],
//           ),
//           const SizedBox(height: 4),
//           Row(
//             children: [
//               const Icon(Icons.calendar_today, size: 16),
//               const SizedBox(width: 4),
//               Text('From: ${leave['fromDate'] ?? ''}'),
//               const SizedBox(width: 12),
//               Text('To: ${leave['toDate'] ?? ''}'),
//             ],
//           ),
//           const SizedBox(height: 4),
//           Row(
//             children: [
//               const Icon(Icons.access_time, size: 16),
//               const SizedBox(width: 4),
//               Text('${leave['sessionFrom'] ?? ''} - ${leave['sessionTo'] ?? ''}'),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/apply_leave_controller.dart';


class ApplyLeaveView extends GetView<ApplyLeaveController> {
  const ApplyLeaveView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Leave", style: TextStyle(color: Colors.black)),
          leading: const BackButton(color: Colors.black),
          backgroundColor: Colors.white,
          bottom: const TabBar(
            tabs: [
              Tab(text: "Pending"),
              Tab(text: "History"),
            ],
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
                ),
                child: ListTile(
                  leading: Image.asset("assets/images/suitcase.png", height: 40),
                  title: const Text("Apply for Leaves"),
                  subtitle: const Text("Account for your absence by managing leaves."),
                  trailing: ElevatedButton(
                    onPressed: () => _showApplyBottomSheet(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text("Apply Now"),
                  ),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Obx(() => controller.pendingLeaves.isEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                    itemCount: controller.pendingLeaves.length,
                    itemBuilder: (_, i) => _buildLeaveCard(controller.pendingLeaves[i]),
                  )),
                  Obx(() => ListView.builder(
                    itemCount: controller.historyLeaves.length,
                    itemBuilder: (_, i) => _buildLeaveCard(controller.historyLeaves[i]),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/images/empty.png", height: 160),
        const SizedBox(height: 20),
        const Text("It’s empty here!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        const Text("Your pending leave requests will appear here.", style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildLeaveCard(Map<String, dynamic> leave) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${leave['type'] ?? ''} - ${leave['days'] ?? ''} day(s)",



                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(Icons.folder, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text("Status: ${leave['status'] ==    'Approved'}", style: TextStyle(color: Colors.blue.shade700)),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text("Applied On: ${leave['appliedDate'] ?? ''}"),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(Icons.date_range, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text("From: ${leave['fromDate'] ?? ''} (${leave['sessionFrom'] ?? ''})"),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.date_range, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text("To: ${leave['toDate'] ?? ''} (${leave['sessionTo'] ?? ''})"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showApplyBottomSheet(BuildContext context) {
    final List<Map<String, String>> options = [
      {'title': 'Leave', 'icon': 'assets/images/suitcase.png'},
      {'title': 'Restricted Holiday', 'icon': 'assets/images/holiday.png'},
      {'title': 'Comp Off Grant', 'icon': 'assets/images/leave comp.png'},
      {'title': 'Leave Cancel', 'icon': 'assets/images/leave_cancel.png'},
    ];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text("Apply For", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            ...options.map((option) => ListTile(
              leading: Image.asset(option['icon']!, height: 40),
              title: Text(option['title']!),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => Get.back(), // Simulate navigation
            )),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }
}
