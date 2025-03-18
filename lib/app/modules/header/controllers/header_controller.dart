import 'package:get/get.dart';

class HeaderController extends GetxController {
  // Observable for sidebar state
  // User initials
  var userInitials = 'OK'.obs; // Replace with dynamic user data

  // Sidebar open/close state
  var isSidebarOpen = false.obs;

  // Toggle sidebar
  void toggleSidebar() {
    isSidebarOpen.value = !isSidebarOpen.value;
  }

  // Logout action
  void logout() {
    print("User logged out");
  }

  // Optional: Fetch user initials dynamically if required
  void fetchUserInitials(String firstName, String lastName) {
    final initials = "${firstName[0]}${lastName[0]}".toUpperCase();
    userInitials.value = initials;
  }

  @override
  void onInit() {
    super.onInit();
    // You can initialize user data here if needed
    // For example:
    // fetchUserInitials("John", "Doe");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
