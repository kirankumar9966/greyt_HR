import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/todo_controller.dart';

class TodoDetailView extends StatelessWidget {
  final String tab;
  final String image;


  const TodoDetailView({super.key, required this.tab, required this.image});

  @override
  Widget build(BuildContext context) {
    final TodoController controller = Get.find();

    final showSubTabs = controller.getSubTabs(tab, image).isNotEmpty;
    controller.getSubTabs(tab, image);

    return DefaultTabController(
      length: showSubTabs ? 2 : 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            image.split('/').last.split('.').first.replaceAll('_', ' '),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 1,
          bottom: showSubTabs
              ? const TabBar(
            tabs: [
              Tab(text: 'Active'),
              Tab(text: 'Closed'),
            ],
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.black,
            indicatorColor: Colors.blue,
          )
              : null,
        ),
        backgroundColor: const Color(0xFFF5F6FA),
        body: showSubTabs
            ? const TabBarView(
          children: [
            Center(child: Text('Active View')),
            Center(child: Text('Closed View')),
          ],
        )
            : Center(child: Text('No detailed view available')),
      ),
    );
  }
}
