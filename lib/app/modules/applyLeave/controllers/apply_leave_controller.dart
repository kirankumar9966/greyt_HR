import 'package:get/get.dart';


class ApplyLeaveController extends GetxController {
  // Sample Pending Leaves
  final RxList<Map<String, dynamic>> pendingLeaves = <Map<String, dynamic>>[
    {
      'type': 'Sick Leave',
      'days': 1,
      'status': 'Pending',
      'fromDate': '15 Jun 2025',
      'toDate': '15 Jun 2025',
      'appliedDate': '14 Jun 2025',
      'sessionFrom': 'Session 1',
      'sessionTo': 'Session 2',
    },
  ].obs;

  // Sample History Leaves
  final RxList<Map<String, dynamic>> historyLeaves = <Map<String, dynamic>>[
    {
      'type': 'Earned Leave',
      'days': 1,
      'status': 'Approved',
      'fromDate': '10 Jun 2025',
      'toDate': '10 Jun 2025',
      'appliedDate': '09 Jun 2025',
      'sessionFrom': 'Session 1',
      'sessionTo': 'Session 2',
    },
    {
      'type': 'Casual Leave',
      'days': 0.5,
      'status': 'Approved',
      'fromDate': '08 Jun 2025',
      'toDate': '08 Jun 2025',
      'appliedDate': '07 Jun 2025',
      'sessionFrom': 'Session 1',
      'sessionTo': 'Session 1',
    },
    {
      'type': 'Maternity Leave',
      'days': 90,
      'status': 'Approved',
      'fromDate': '01 Apr 2025',
      'toDate': '30 Jun 2025',
      'appliedDate': '15 Mar 2025',
      'sessionFrom': 'Full Day',
      'sessionTo': 'Full Day',
    },
  ].obs;
}
