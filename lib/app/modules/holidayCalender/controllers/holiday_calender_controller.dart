import 'package:get/get.dart';
import '../../../services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../dashboard/models/HolidayCalender.dart';

class HolidayCalenderController extends GetxController {
  var selectedYear = 2025.obs;
  var selectedHolidayType = "All Holidays".obs;

  RxList<Holiday> allHolidays = <Holiday>[].obs;
  RxList<Holiday> filteredHolidays = <Holiday>[].obs;
  RxList<Holiday> upcomingHolidays = <Holiday>[].obs;

  var isHolidayLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchHolidays();
  }

  Future<void> fetchHolidays() async {
    final token = AuthService.getToken();
    final empId = AuthService.getEmpId();

    if (token == null || empId == null) {
      Get.snackbar("Error", "Login token or empId missing");
      return;
    }

    try {
      isHolidayLoading.value = true;

      final response = await http.post(
        Uri.parse("https://s6.payg-india.com/api/holidays"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final model = HolidayCalendarModel.fromJson(data);

        allHolidays.assignAll(model.data.holidays);
        filterHolidays();

        // 🎯 Upcoming logic
        final today = DateTime.now();
        final upcoming = model.data.holidays.where((holiday) {
          final date = DateTime.tryParse(holiday.date);
          return date != null && !date.isBefore(today);
        }).toList();

        upcoming.sort((a, b) => a.date.compareTo(b.date));
        upcomingHolidays.assignAll(upcoming.take(4));
      } else {
        Get.snackbar("Error", "Failed to load holidays");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isHolidayLoading.value = false;
    }
  }

  void filterHolidays() {
    List<Holiday> filtered = allHolidays.where((h) {
      final holidayDate = DateTime.tryParse(h.date);
      return holidayDate != null &&
          holidayDate.year == selectedYear.value;
    }).toList();

    filteredHolidays.assignAll(filtered);
  }

  void updateYear(int year) {
    selectedYear.value = year;
    filterHolidays();
  }

  void updateHolidayType(String type) {
    selectedHolidayType.value = type;
    filterHolidays();
  }
}
