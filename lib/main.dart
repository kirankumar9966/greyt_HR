import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:greyt_hr/app/modules/aboutThisApp/controllers/about_this_app_controller.dart';
import 'package:greyt_hr/app/modules/action/controllers/action_controller.dart';
import 'package:greyt_hr/app/modules/applyLeave/controllers/apply_leave_controller.dart';
import 'package:greyt_hr/app/modules/applyRegularization/controllers/apply_regularization_controller.dart';
import 'package:greyt_hr/app/modules/attendanceInfo/controllers/attendance_info_controller.dart';
import 'package:greyt_hr/app/modules/changePassword/controllers/change_password_controller.dart';
import 'package:greyt_hr/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:greyt_hr/app/modules/dayDetails/controllers/day_details_controller.dart';
import 'package:greyt_hr/app/modules/dayDetails/views/day_details_view.dart';
import 'package:greyt_hr/app/modules/engage/controllers/engage_controller.dart';
import 'package:greyt_hr/app/modules/explore/controllers/explore_controller.dart';
import 'package:greyt_hr/app/modules/footer/controllers/footer_controller.dart';
import 'package:greyt_hr/app/modules/header/controllers/header_controller.dart';
import 'package:greyt_hr/app/modules/holidayCalender/controllers/holiday_calender_controller.dart';
import 'package:greyt_hr/app/modules/leaveBalance/controllers/leave_balance_controller.dart';
import 'package:greyt_hr/app/modules/newPinSetup/controllers/new_pin_setup_controller.dart';
import 'package:greyt_hr/app/modules/payslipDetails/controllers/payslip_details_controller.dart';
import 'package:greyt_hr/app/modules/payslips/controllers/payslips_controller.dart';
import 'package:greyt_hr/app/modules/privacyAndSecurity/controllers/privacy_and_security_controller.dart';
import 'package:greyt_hr/app/modules/profile/controllers/profile_controller.dart';
import 'package:greyt_hr/app/modules/resign/controllers/resign_controller.dart';
import 'package:greyt_hr/app/modules/settings/controllers/settings_controller.dart';
import 'package:greyt_hr/app/modules/updates/controllers/updates_controller.dart';

import 'app/modules/login/controllers/login_controller.dart';
import 'app/routes/app_pages.dart';


void main() async {
  await GetStorage.init();
  Get.put(LoginController());
  Get.put(DashboardController());
  Get.put(HeaderController());
  Get.put(ProfileController());
  Get.put(SettingsController());
  Get.put(UpdatesController());
  Get.put(ResignController());
  Get.put(AboutThisAppController());
  Get.put(PrivacyAndSecurityController());
  Get.put(NewPinSetupController());
  Get.put(ChangePasswordController());
  Get.put(FooterController());
  Get.put(EngageController());
  Get.put(ActionController());
  Get.put(ExploreController());
  Get.put(ApplyRegularizationController());
  Get.put(AttendanceInfoController());
  Get.put(ApplyLeaveController());
  Get.put(LeaveBalanceController());
  Get.put(HolidayCalenderController());
  Get.put(DayDetailsController());
  Get.put(PayslipsController());
  Get.put(PayslipDetailsController());

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
