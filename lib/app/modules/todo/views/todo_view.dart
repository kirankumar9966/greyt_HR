import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/todo_controller.dart';
import 'todo_detail_view.dart';
//import '../views/todo_detail_view.dart';
//
//
// class ToDoView extends GetView<TodoController> {
//   const ToDoView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: controller.tabs.length,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             'To Do Review',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           centerTitle: true,
//           backgroundColor: Colors.white,
//           elevation: 0,
//           bottom: PreferredSize(
//             preferredSize: const Size.fromHeight(48),
//             child: Container(
//               margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFF0F0F0),
//                 borderRadius: BorderRadius.circular(30),
//               ),
//               child: TabBar(
//                 controller: controller.tabController,
//                 isScrollable: true,
//                 indicator: BoxDecoration(
//                   color: Colors.blue.shade100,
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 labelColor: Colors.blue,
//                 unselectedLabelColor: Colors.black,
//                 tabs: controller.tabs.map((tab) => Tab(text: tab)).toList(),
//               ),
//             ),
//           ),
//         ),
//         backgroundColor: const Color(0xFFF5F6FA),
//         body: TabBarView(
//           controller: controller.tabController,
//           children: controller.tabs.map((tab) {
//             final images = controller.tabImages[tab] ?? [];
//             return GridView.builder(
//               padding: const EdgeInsets.all(16),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 16,
//                 mainAxisSpacing: 16,
//                 childAspectRatio: 0.9,
//               ),
//               itemCount: images.length,
//               itemBuilder: (context, index) {
//                 final image = images[index];
//                 return GestureDetector(
//                   onTap: () {
//                     controller.openDetail(tab, image);
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(16),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.2),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                           offset: const Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Image.asset(
//                           image,
//                           height: 80,
//                           fit: BoxFit.contain,
//                         ),
//                         const SizedBox(height: 12),
//                         Text(
//                           image.split('/').last.split('.').first.replaceAll('_', ' '),
//                           textAlign: TextAlign.center,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }
//
// import 'package:flutter/material.dart';
//
// import 'package:get/get.dart';
//
// import '../controllers/todo_controller.dart';
//
// class TodoView extends GetView<TodoController> {
//   const TodoView({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('TodoView'),
//         centerTitle: true,
//       ),
//       body: const Center(
//         child: Text(
//           'TodoView is working',
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/todo_controller.dart';
//
// class TodoView extends GetView<TodoController> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('To Do Review'),
//         bottom: TabBar(
//           controller: controller.tabController,
//           isScrollable: true,
//           tabs: controller.allTabs.map((e) => Tab(text: e)).toList(),
//           onTap: (index) => controller.updateTabIndex(index),
//         ),
//       ),
//       body: Obx(() {
//         String currentTab = controller.allTabs[controller.tabIndex.value];
//         var items = controller.getImagesForTab(currentTab);
//
//         return GridView.builder(
//           padding: const EdgeInsets.all(12),
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 12,
//             mainAxisSpacing: 12,
//           ),
//           itemCount: items.length,
//           itemBuilder: (context, index) {
//             final item = items[index];
//             return GestureDetector(
//               onTap: () => controller.navigateToSubTab(item['title']!, item['image']!),
//               child: Card(
//                 elevation: 4,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image.asset(item['image']!, height: 60),
//                     const SizedBox(height: 10),
//                     Text(item['title']!, textAlign: TextAlign.center),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/todo_controller.dart';

class TodoView extends GetView<TodoController> {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: controller.tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'To Do Review',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F0F0),
                borderRadius: BorderRadius.circular(30),
              ),
              child: TabBar(
                controller: controller.tabController,
                isScrollable: true,
                indicator: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(30),
                ),
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.black,
                tabs: controller.tabs.map((tab) => Tab(text: tab)).toList(),
              ),
            ),
          ),
        ),
        backgroundColor: const Color(0xFFF5F6FA),
        body: TabBarView(
          controller: controller.tabController,
          children: controller.tabs.map((tab) {
            final images = controller.tabImages[tab] ?? [];
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.9,
              ),
              itemCount: images.length,
              itemBuilder: (context, index) {
                final image = images[index];
                return GestureDetector(
                  onTap: () {
                    controller.openDetail(tab, image);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          image,
                          height: 80,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          image.split('/').last.split('.').first.replaceAll('_', ' '),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

