import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greyt_hr/app/modules/footer/views/footer_view.dart';
import '../controllers/explore_controller.dart';

class ExploreView extends GetView<ExploreController> {
  const ExploreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        automaticallyImplyLeading: false,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Obx(() => buildFeatureCard(
              title: 'Attendance',
              subtitle: 'Manage your attendance.',
              actions: {
                'Attendance Info': '/attendance-info',
                'Apply Regularization': '/apply-regularization',


              },
              icon: Icons.check_circle_outline,
              color: Colors.blueAccent,
              index: 0,
            )),
            Obx(() => buildFeatureCard(
              title: 'Leave',
              subtitle: 'Check and apply for leaves.',
              actions: {
                'Apply Leave': '/dashboard',
                'Leave Balance': '/dashboard',
                //'Holiday Calendar': '/holiday-calender',
                'Holiday Calendar': '/holidaycenter',

              },
              icon: Icons.beach_access,
              color: Colors.teal,
              index: 1,
            )),
            Obx(() => buildFeatureCard(
              title: 'Salary',
              subtitle: 'Get Your Salary Breakdown.',
              actions: {
                'Payslips': '/dashboard',
                'YTD Reports': '/dashboard',
                'IT Statements': '/dashboard',
                'IT Declaration': '/dashboard',
              },
              icon: Icons.payments,
              color: Colors.orange,
              index: 2,
            )),
            Obx(() => buildFeatureCard(
              title: 'My Worklife',
              subtitle: 'Collaborate, learn, and grow together.',
              actions: {
                'Kudos': '/dashboard',
              },
              icon: Icons.people_alt,
              color: Colors.deepPurple,
              index: 3,
            )),
            Obx(() => buildFeatureCard(
              title: 'People',
              subtitle: 'A data hub for personal info and workmates.',
              actions: {
                'My profile': '/profile',
                'My Workmates': '/dashboard',
                'My profile': '/myprofile',
                'My Workmates': '/myworkmates',
              },
              icon: Icons.group,
              color: Colors.blue,
              index: 4,
            )),
            Obx(() => buildFeatureCard(
              title: 'To Do',
              subtitle: 'Review Pending Items.',
              actions: {
                'Review': '/review-pending-regularization',
                'Review': '/todo',
              },
              icon: Icons.task,
              color: Colors.orange,
              index: 5,
            )),
            Obx(() => buildFeatureCard(
              title: 'Helpdesk',
              subtitle: 'Request assistance here.',
              icon: Icons.help_outline,
              color: Colors.green,
              index: 6,
              actions: {
                'Helpdesk': '/helpdesk',
              },

            )),
            Obx(() => buildFeatureCard(
              title: 'Documents',
              subtitle: 'Check or request documents.',
              icon: Icons.description,
              color: Colors.teal,
              index: 7,
              actions: {
                'Document': '/documentcenter',

              },

            )),
          ],
        ),
      ),
      bottomNavigationBar: FooterView(),
    );
  }

  Widget buildFeatureCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    Map<String, String>? actions,
    required int index,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ExpansionTile(
        key: PageStorageKey<int>(index),
        initiallyExpanded: controller.expandedIndex.value == index,
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color, size: 30),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey)),
        onExpansionChanged: (expanded) {
          controller.toggleExpansion(index); // Toggle the expansion state
        },
        childrenPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        children: actions != null && actions.isNotEmpty
            ? [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: actions.entries
                .map(
                  (entry) => SizedBox(
                width: (MediaQuery.of(Get.context!).size.width - 60) /
                    2, // Adjust width for two buttons per row
                height: 40,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () => Get.toNamed(entry.value),
                  child: Text(
                    entry.key,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
                .toList(),
          )
        ]
            : [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              subtitle,
              style: TextStyle(
                  color: Colors.grey.shade700, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
