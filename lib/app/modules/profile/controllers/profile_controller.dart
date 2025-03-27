import 'package:get/get.dart';
import 'package:greyt_hr/app/services/auth_service.dart';
import '../models/ProfileModel.dart';

class ProfileController extends GetxController {
  var isLoading = true.obs;
  var employee = Rxn<Employee>();

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;
      final profileModel = await AuthService.fetchEmployeeDetails();
      if (profileModel != null && profileModel.data.employee.empId.isNotEmpty) {
        employee.value = profileModel.data.employee;
        print("✅ Profile loaded: ${employee.value?.empId}");
      } else {
        Get.snackbar("Error", "Failed to load profile data.");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
