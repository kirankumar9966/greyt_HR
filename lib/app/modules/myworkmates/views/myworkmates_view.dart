import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/myworkmates_controller.dart';
import 'employee_detail_view.dart';


class MyworkmatesView extends GetView<MyworkmatesController> {
  const MyworkmatesView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('People'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Starred'),
              Tab(text: 'Everyone'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Obx(() => _buildEmployeeList(controller.starredEmployees)),
            Obx(() => _buildEmployeeList(controller.allEmployees)),
          ],
        ),
      ),
    );
  }

  Widget _buildEmployeeList(RxList<Map<String, dynamic>> list) {
    if (list.isEmpty) {
      return const Center(child: Text("No employees found."));
    }

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final emp = list[index];
        final isStarred = controller.isStarred(emp['id']);

        return ListTile(
          leading: CircleAvatar(
            child: Text(emp['name'].toString().isNotEmpty
                ? emp['name'][0]
                : '?'),
          ),
          title: Text(emp['name'] ?? ''),
          subtitle: Text(emp['id'] ?? ''),
          trailing: IconButton(
            icon: Icon(
              isStarred ? Icons.star : Icons.star_border,
              color: isStarred ? Colors.orange : Colors.grey,
            ),
            onPressed: () {
              controller.toggleStar(emp);
            },
          ),
          onTap: () {
            Get.to(() => EmployeeDetailView(employee: emp));
          },
        );
      },
    );
  }
}
