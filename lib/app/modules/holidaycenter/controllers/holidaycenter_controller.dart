import 'package:get/get.dart';

class HolidayModel {
  final DateTime date;
  final String title;

  HolidayModel(this.date, this.title);
}

class HolidaycenterController extends GetxController {
  final selectedYear = ''.obs;
  final selectedCategory = ''.obs;

  final yearOptions = [
    'Jan 2025 - Dec 2025',
    'Jan 2026 - Dec 2026',
    'Jan 2024 - Dec 2024',
    'Jan 2023 - Dec 2023',
    'Jan 2022 - Dec 2022',
  ];

  final categoryOptions = ['All Holidays', 'Restricted Holidays', 'General Holidays'];

  final holidays = <HolidayModel>[
    HolidayModel(DateTime(2025, 1, 1), 'New Year'),
    HolidayModel(DateTime(2025, 1, 14), 'Sankranthi'),
    HolidayModel(DateTime(2025, 3, 14), 'Holi'),
    HolidayModel(DateTime(2025, 3, 31), 'Idul Fitr / Ramzan'),
    HolidayModel(DateTime(2025, 5, 1), 'May Day'),
    HolidayModel(DateTime(2025, 6, 2), 'Telangana Formation Day'),
    HolidayModel(DateTime(2025, 8, 15), 'Independence Day'),
    HolidayModel(DateTime(2025, 10, 2), 'Gandhi Jayanthi'),
    HolidayModel(DateTime(2025, 10, 3), 'Vijaya Dashami'),
    HolidayModel(DateTime(2025, 10, 20), 'Deepavali'),
    HolidayModel(DateTime(2025, 12, 25), 'Christmas'),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    selectedYear.value = yearOptions.first;
    selectedCategory.value = categoryOptions.first;
  }

  int extractYear(String yearString) {
    final match = RegExp(r'\d{4}').firstMatch(yearString);
    return match != null ? int.parse(match.group(0)!) : DateTime.now().year;
  }

  List<HolidayModel> holidaysForMonth(int month) {
    final year = extractYear(selectedYear.value);
    return holidays.where((h) => h.date.month == month && h.date.year == year).toList();
  }

  void setYear(String year) => selectedYear.value = year;
  void setCategory(String category) => selectedCategory.value = category;
}

