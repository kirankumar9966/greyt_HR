import 'package:get/get.dart';
import '../../../services/myworkmates_service.dart';


class MyworkmatesController extends GetxController {
  var allEmployees = <Map<String, dynamic>>[].obs;
  var starredEmployees = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchEmployees();
  }

  void fetchEmployees() async {
    try {
      final data = await MyWorkmatesService.fetchAllEmployeeDetails();
      allEmployees.assignAll(data);
    } catch (e) {
      print("Error loading employee data: $e");
    }
  }

  void toggleStar(Map<String, dynamic> employee) {
    if (starredEmployees.any((e) => e['id'] == employee['id'])) {
      starredEmployees.removeWhere((e) => e['id'] == employee['id']);
    } else {
      starredEmployees.add(employee);
    }
  }

  bool isStarred(String id) {
    return starredEmployees.any((e) => e['id'] == id);
  }
}
