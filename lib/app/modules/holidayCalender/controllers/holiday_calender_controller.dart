import 'package:get/get.dart';

class HolidayCalenderController extends GetxController {
  // Selected Year & Holiday Type
  var selectedYear = 2025.obs;
  var selectedHolidayType = "All Holidays".obs;

  // Holiday List (Mock Data for Now)
  var holidays = <Map<String, dynamic>>[
    // ✅ January
    {"date": "01", "month": "Jan", "year": 2025, "day": "Wed", "name": "New Year"},
    {"date": "14", "month": "Jan", "year": 2025, "day": "Tue", "name": "Makar Sankranti / Pongal"},
    {"date": "26", "month": "Jan", "year": 2025, "day": "Sun", "name": "Republic Day"},

    // ✅ February
    {"date": "14", "month": "Feb", "year": 2025, "day": "Fri", "name": "Vasant Panchami"},
    {"date": "19", "month": "Feb", "year": 2025, "day": "Wed", "name": "Shivaji Jayanti"},

    // ✅ March
    {"date": "14", "month": "Mar", "year": 2025, "day": "Fri", "name": "Holi"},
    {"date": "17", "month": "Mar", "year": 2025, "day": "Mon", "name": "Chaitra Navratri"},

    // ✅ April
    {"date": "10", "month": "Apr", "year": 2025, "day": "Thu", "name": "Ram Navami"},
    {"date": "14", "month": "Apr", "year": 2025, "day": "Mon", "name": "Dr. Ambedkar Jayanti"},

    // ✅ May
    {"date": "01", "month": "May", "year": 2025, "day": "Thu", "name": "Labour Day"},
    {"date": "14", "month": "May", "year": 2025, "day": "Wed", "name": "Buddha Purnima"},

    // ✅ June
    {"date": "06", "month": "Jun", "year": 2025, "day": "Fri", "name": "Ganga Dussehra"},
    {"date": "17", "month": "Jun", "year": 2025, "day": "Tue", "name": "Eid-ul-Adha / Bakrid"},

    // ✅ July
    {"date": "09", "month": "Jul", "year": 2025, "day": "Wed", "name": "Muharram"},
    {"date": "29", "month": "Jul", "year": 2025, "day": "Tue", "name": "Nag Panchami"},

    // ✅ August
    {"date": "15", "month": "Aug", "year": 2025, "day": "Fri", "name": "Independence Day"},
    {"date": "19", "month": "Aug", "year": 2025, "day": "Tue", "name": "Raksha Bandhan"},
    {"date": "25", "month": "Aug", "year": 2025, "day": "Mon", "name": "Janmashtami"},

    // ✅ September
    {"date": "07", "month": "Sep", "year": 2025, "day": "Sun", "name": "Ganesh Chaturthi"},
    {"date": "14", "month": "Sep", "year": 2025, "day": "Sun", "name": "Onam"},

    // ✅ October
    {"date": "02", "month": "Oct", "year": 2025, "day": "Thu", "name": "Gandhi Jayanti"},
    {"date": "07", "month": "Oct", "year": 2025, "day": "Tue", "name": "Maha Navami"},
    {"date": "08", "month": "Oct", "year": 2025, "day": "Wed", "name": "Dussehra"},
    {"date": "17", "month": "Oct", "year": 2025, "day": "Fri", "name": "Eid Milad-un-Nabi"},

    // ✅ November
    {"date": "01", "month": "Nov", "year": 2025, "day": "Sat", "name": "Kannada Rajyotsava"},
    {"date": "13", "month": "Nov", "year": 2025, "day": "Thu", "name": "Diwali"},
    {"date": "15", "month": "Nov", "year": 2025, "day": "Sat", "name": "Bhai Dooj"},

    // ✅ December
    {"date": "25", "month": "Dec", "year": 2025, "day": "Thu", "name": "Christmas"},
  ].obs;


  // Filtered Holidays Based on Selection
  RxList<Map<String, dynamic>> filteredHolidays = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    filterHolidays(); // Initialize with default selection
  }

  // Filter Holidays Based on Year & Type
  void filterHolidays() {
    filteredHolidays.clear();

    var selected = holidays.where((holiday) => holiday['year'] == selectedYear.value).toList();

    if (selectedHolidayType.value == "General Holidays") {
      // Only show months that have holidays
      var monthsWithHolidays = selected.map((e) => e["month"]).toSet();
      selected = selected.where((e) => monthsWithHolidays.contains(e["month"])).toList();
    }

    filteredHolidays.addAll(selected);
  }

  // Update Year Selection
  void updateYear(int year) {
    selectedYear.value = year;
    filterHolidays();
  }

  // Update Holiday Type Selection
  void updateHolidayType(String type) {
    selectedHolidayType.value = type;
    filterHolidays();
  }
}
