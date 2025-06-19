import 'package:get/get.dart';


//class RegularizationController extends GetxController {
  //TODO: Implement RegularizationController

  var selectedDate = DateTime
      .now()
      .obs;


  void changeDate(DateTime date) {
    selectedDate.value = date;
  }

enum RegularizationTab { apply, pending, history }

class RegularizationController extends GetxController {
  // Whether we show the main page (with buttons) or the tab layout.
  var showMainPage = true.obs;

  // Which tab is currently selected.
  var selectedTab = RegularizationTab.apply.obs;

  // Switch to the main page.
  void goToMainPage() {
    showMainPage.value = true;
  }

  // Switch to the tab layout with the specified tab.
  void goToTabs(RegularizationTab tab) {
    showMainPage.value = false;
    selectedTab.value = tab;
  }
}



