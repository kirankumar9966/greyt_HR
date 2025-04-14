import 'package:get/get.dart';

import '../modules/aboutThisApp/bindings/about_this_app_binding.dart';
import '../modules/aboutThisApp/views/about_this_app_view.dart';
import '../modules/action/bindings/action_binding.dart';
import '../modules/action/views/action_view.dart';
import '../modules/applyLeave/bindings/apply_leave_binding.dart';
import '../modules/applyLeave/views/apply_leave_view.dart';
import '../modules/applyRegularization/bindings/apply_regularization_binding.dart';
import '../modules/applyRegularization/views/apply_regularization_view.dart';
import '../modules/attendanceInfo/bindings/attendance_info_binding.dart';
import '../modules/attendanceInfo/views/attendance_info_view.dart';
import '../modules/casualLeave/bindings/casual_leave_binding.dart';
import '../modules/casualLeave/views/casual_leave_view.dart';
import '../modules/changePassword/bindings/change_password_binding.dart';
import '../modules/changePassword/views/change_password_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/dayDetails/bindings/day_details_binding.dart';
import '../modules/dayDetails/views/day_details_view.dart';
import '../modules/disablePin/bindings/disable_pin_binding.dart';
import '../modules/disablePin/views/disable_pin_view.dart';
import '../modules/edtiPin/bindings/edti_pin_binding.dart';
import '../modules/edtiPin/views/edti_pin_view.dart';
import '../modules/engage/bindings/engage_binding.dart';
import '../modules/engage/views/engage_view.dart';
import '../modules/explore/bindings/explore_binding.dart';
import '../modules/explore/views/explore_view.dart';
import '../modules/footer/bindings/footer_binding.dart';
import '../modules/footer/views/footer_view.dart';
import '../modules/header/bindings/header_binding.dart';
import '../modules/header/views/header_view.dart';
import '../modules/holidayCalender/bindings/holiday_calender_binding.dart';
import '../modules/holidayCalender/views/holiday_calender_view.dart';
import '../modules/leaveBalance/bindings/leave_balance_binding.dart';
import '../modules/leaveBalance/views/leave_balance_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/newPinSetup/bindings/new_pin_setup_binding.dart';
import '../modules/newPinSetup/views/new_pin_setup_view.dart';
import '../modules/payslipDetails/bindings/payslip_details_binding.dart';
import '../modules/payslipDetails/views/payslip_details_view.dart';
import '../modules/payslips/bindings/payslips_binding.dart';
import '../modules/payslips/views/payslips_view.dart';
import '../modules/privacyAndSecurity/bindings/privacy_and_security_binding.dart';
import '../modules/privacyAndSecurity/views/privacy_and_security_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/resign/bindings/resign_binding.dart';
import '../modules/resign/views/resign_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/updates/bindings/updates_binding.dart';
import '../modules/updates/views/updates_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.HEADER,
      page: () => const HeaderView(),
      binding: HeaderBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () =>  ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.UPDATES,
      page: () => const UpdatesView(),
      binding: UpdatesBinding(),
    ),
    GetPage(
      name: _Paths.RESIGN,
      page: () => const ResignView(),
      binding: ResignBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT_THIS_APP,
      page: () => const AboutThisAppView(),
      binding: AboutThisAppBinding(),
    ),
    GetPage(
      name: _Paths.PRIVACY_AND_SECURITY,
      page: () => const PrivacyAndSecurityView(),
      binding: PrivacyAndSecurityBinding(),
    ),
    GetPage(
      name: _Paths.NEW_PIN_SETUP,
      page: () => NewPinSetupView(),
      binding: NewPinSetupBinding(),
    ),
    GetPage(
      name: _Paths.EDTI_PIN,
      page: () => const EdtiPinView(),
      binding: EdtiPinBinding(),
    ),
    GetPage(
      name: _Paths.DISABLE_PIN,
      page: () => const DisablePinView(),
      binding: DisablePinBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.FOOTER,
      page: () => const FooterView(),
      binding: FooterBinding(),
    ),
    GetPage(
      name: _Paths.ACTION,
      page: () => const ActionView(),
      binding: ActionBinding(),
    ),
    GetPage(
      name: _Paths.EXPLORE,
      page: () => const ExploreView(),
      binding: ExploreBinding(),
    ),
    GetPage(
      name: _Paths.ENGAGE,
      page: () => const EngageView(),
      binding: EngageBinding(),
    ),
    GetPage(
      name: _Paths.APPLY_REGULARIZATION,
      page: () => const ApplyRegularizationView(),
      binding: ApplyRegularizationBinding(),
    ),
    GetPage(
      name: _Paths.ATTENDANCE_INFO,
      page: () => AttendanceInfoView(),
      binding: AttendanceInfoBinding(),
    ),
    GetPage(
      name: _Paths.APPLY_LEAVE,
      page: () => const ApplyLeaveView(),
      binding: ApplyLeaveBinding(),
    ),
    GetPage(
      name: _Paths.LEAVE_BALANCE,
      page: () => const LeaveBalanceView(),
      binding: LeaveBalanceBinding(),
    ),
    GetPage(
      name: _Paths.HOLIDAY_CALENDER,
      page: () => const HolidayCalenderView(),
      binding: HolidayCalenderBinding(),
    ),
    GetPage(
      name: _Paths.DAY_DETAILS,
      page: () => const DayDetailsView(),
      binding: DayDetailsBinding(),
    ),
    GetPage(
      name: _Paths.PAYSLIPS,
      page: () => const PayslipsView(),
      binding: PayslipsBinding(),
    ),
    GetPage(
      name: _Paths.PAYSLIP_DETAILS,
      page: () => const PayslipDetailsView(),
      binding: PayslipDetailsBinding(),
    ),
    GetPage(
      name: _Paths.CASUAL_LEAVE,
      page: () => const CasualLeaveView(),
      binding: CasualLeaveBinding(),
    ),

    GetPage(
      name: _Paths.LOGIN,
      page: () =>  LoginView(),
      binding: LoginBinding(),
    ),
  ];
}
