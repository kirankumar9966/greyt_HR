
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../views/todo_detail_view.dart';
// class TodoController extends GetxController with GetSingleTickerProviderStateMixin {
//   late TabController tabController;
//
//   final List<String> tabs = ['All', 'Attendance', 'Emp Info', 'Leave', 'Trouble Ticket'];
//
//   final Map<String, List<String>> tabImages = {
//     'All': [
//       'assets/images/attendance_regularization.png',
//       'assets/images/resignation.png',
//       'assets/images/leave.png',
//       'assets/images/leavecancel.png',
//       'assets/images/leave comp.png',
//       'assets/images/resticed.png',
//       'assets/images/helpdesk.png',
//     ],
//     'Attendance': ['assets/images/attendance_regularization.png'],
//     'Emp Info': ['assets/images/resignation.png'],
//     'Leave': ['assets/images/leave.png'],
//     'Trouble Ticket': ['assets/images/helpdesk.png'],
//   };
//
//   @override
//   void onInit() {
//     super.onInit();
//     tabController = TabController(length: tabs.length, vsync: this);
//   }
//
//   void openDetail(String tab, String imagePath) {
//     Get.toNamed('/todo-detail', arguments: {'tab': tab, 'image': imagePath});
//   }
//
//   List<String> getSubTabs(String tab, String image) {
//     String imageKey = image.toLowerCase();
//
//     if (tab == 'All') {
//       if (imageKey.contains('attendance')) return ['Active', 'Closed'];
//       if (imageKey.contains('leave')) return ['Active', 'Closed'];
//       if (imageKey.contains('trouble')) return ['Active', 'Closed'];
//     } else if (tab == 'Attendance' && imageKey.contains('attendance')) {
//       return ['Active', 'Closed'];
//     } else if (tab == 'Leave' && imageKey.contains('leave')) {
//       return ['Active', 'Closed'];
//     } else if (tab == 'Trouble Ticket' && imageKey.contains('trouble')) {
//       return ['Active', 'Closed'];
//     }
//
//     return [];
//   }
//
//   @override
//   void onClose() {
//     tabController.dispose();
//     super.onClose();
//   }
// }



//  import 'package:flutter/material.dart';
//  import 'package:get/get.dart';
// import '../views/todo_detail_view.dart';
// class TodoController extends GetxController with GetTickerProviderStateMixin {
//   late TabController tabController;
//   var tabIndex = 0.obs;
//
//
//   final List<String> allTabs = ['All', 'Attendance', 'Emp Info', 'Leave', 'Trouble Ticket'];
//
//   final Map<String, List<Map<String, String>>> images = {
//     'All': [
//       {'title': 'Attendance Regularization', 'image': 'assets/images/attendance_regularization.png'},
//       {'title': 'Resignation', 'image': 'assets/images/resignation.png'},
//       {'title': 'Leave', 'image': 'assets/images/leave.png'},
//       {'title': 'Leave Cancel', 'image': 'assets/images/leavecancel.png'},
//
//
//       {'title': 'Leave Comp off', 'image': 'assets/images/leave comp.png'},
//       {'title': 'Restrictedholiday leave', 'image': 'assets/images/resticed.png'},
//       {'title': 'Helpdesk', 'image': 'assets/images/helpdesk.png'},
//     ],
//     'Leave': [
//       {'title': 'Leave Request', 'image': 'assets/images/leave.png'},
//       {'title': 'Leave Cancel', 'image': 'assets/images/leavecancel.png'},
//       {'title': 'Leave Comp off', 'image': 'assets/images/leave comp.png'},
//       {'title': 'Restricted Holiday leave ', 'image': 'assets/images/resticed.png'},
//     ],
//     'Attendance': [
//       {'title': 'Attendance Regularization', 'image': 'assets/images/attendance_regularization.png'},
//     ],
//     'Emp Info': [
//       {'title': 'Resignation', 'image': 'assets/images/resignation.png'},
//     ],
//     'Trouble Ticket': [
//       {'title': 'Helpdesk', 'image': 'assets/images/helpdesk.png'},
//     ],
//   };
//
//   @override
//   void onInit() {
//     tabController = TabController(length: allTabs.length, vsync: this);
//     super.onInit();
//   }
//
//   void updateTabIndex(int index) {
//     tabIndex.value = index;
//   }
//
//   List<Map<String, String>> getImagesForTab(String tab) {
//     return images[tab] ?? [];
//   }
//
//  //  void navigateToSubTab(String title, String imagePath) {
//  //    Get.toNamed('/todo-detail', arguments: {'title': title, 'image': imagePath});
//  // }
//   void openDetail(String tab, String image) {
//     Get.to(() => TodoDetailView(tab: tab, image: image));
//     }
//   @override
//    void onClose() {
//     tabController.dispose();
//      super.onClose();
//    }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../views/todo_detail_view.dart';

class TodoController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  var tabIndex = 0.obs;
  final List<String> tabs = ['All', 'Attendance', 'Emp Info', 'Leave', 'Trouble Ticket'];

  final Map<String, List<String>> tabImages = {
    'All': [
      'assets/images/attendance_regularization.png',
      'assets/images/resignation.png',
      'assets/images/leave.png',
      'assets/images/leavecancel.png',
      'assets/images/leave comp.png',
      'assets/images/resticed.png',
      'assets/images/helpdesk.png',
    ],
    'Attendance': ['assets/images/attendance_regularization.png'],
    'Emp Info': ['assets/images/resignation.png'],
     'Leave': ['assets/images/leave.png', 'assets/images/leave comp.png', 'assets/images/leavecancel.png', 'assets/images/resticed.png'],
    'Trouble Ticket': ['assets/images/helpdesk.png'],
  };

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  // void openDetail(String tab, String imagePath) {
  //   Get.toNamed('/todo-detail', arguments: {'tab': tab, 'image': imagePath});
  // }

  List<String> getSubTabs(String tab, String image) {
    String imageKey = image.toLowerCase();

    if (tab == 'All') {
      if (imageKey.contains('attendance')) return ['Active', 'Closed'];
      if (imageKey.contains('leave')) return ['Active', 'Closed'];
      if (imageKey.contains('trouble')) return ['Active', 'Closed'];
    } else if (tab == 'Attendance' && imageKey.contains('attendance')) {
      return ['Active', 'Closed'];
    } else if (tab == 'Leave' && imageKey.contains('leave')) {
      return ['Active', 'Closed'];
    } else if (tab == 'Trouble Ticket' && imageKey.contains('trouble')) {
      return ['Active', 'Closed'];
    }

    return [];
  }
  void openDetail(String tab, String image) {
    Get.to(() => TodoDetailView(tab: tab, image: image));
     }
  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}


