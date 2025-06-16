import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../dayDetails/controllers/day_details_controller.dart';
import '../../dayDetails/views/day_details_view.dart';

class AttendanceInfoController extends GetxController with GetTickerProviderStateMixin {
  // var currentDate = DateTime.now().obs;
  // final ValueNotifier<DateTime> currentDate = ValueNotifier(DateTime.now());
  late TabController tabController;
  final Rx<DateTime> currentDate = DateTime.now().obs;

  var selectedIndex = 0.obs;

  var toggleSelection = [true, false].obs; // Default to calendar view
  var isCalendarView = true.obs; // Tracks the current view
// Attendance Data
  var present = 12.obs;
  var absent = 1.obs;
  var onLeave = 2.obs;
  var holiday = 2.obs;
  var restDay = 0.obs;
  // Getter for formatted month and year (e.g., Mar'25)

  AttendanceInfoController()
  {
    print("Initial Month Range: $currentMonthRange");
    print('Total rest days (Sat & Sun): $restDay'); // 👈 print here
    // updateAttendance(presentCount: presentCount, absentCount: absentCount, onLeaveCount: onLeaveCount, holidayCount: holidayCount, restDayCount: restDayCount);

  }
  String get currentMonthYear {
    return "${monthNames[currentDate.value.month - 1]}'${currentDate.value.year % 100}";
  }

  String get currentMonthRange {
    final date = currentDate.value;
    final start = DateTime(date.year, date.month, 1);
    final end = DateTime(date.year, date.month + 1, 0);
    final formatter = DateFormat("dd MMM");
    return "${formatter.format(start)} - ${formatter.format(end)}";
  }

  int calculateRestDaysInMonth() {
    final date = currentDate.value;
    final start = DateTime(date.year, date.month, 1);
    final end = DateTime(date.year, date.month + 1, 0);

    int restDays = 0;

    for (int i = 0; i <= end.difference(start).inDays; i++) {
      final day = start.add(Duration(days: i));
      if (day.weekday == DateTime.saturday || day.weekday == DateTime.sunday) {
        restDays++;
      }
    }

    print('Total rest days (Sat & Sun): $restDays'); // 👈 print here

    return restDays;

  }

  int get currentMonthWorkingDays {
    final date = currentDate.value;
    final start = DateTime(date.year, date.month, 1);
    final end = DateTime(date.year, date.month + 1, 0);

    int workingDays = 0;

    for (int i = 0; i <= end.difference(start).inDays; i++) {
      final day = start.add(Duration(days: i));
      if (day.weekday != DateTime.saturday && day.weekday != DateTime.sunday) {
        workingDays++;
      }
    }

    return workingDays;
  }

  String getCurrentMonthRangeAndWeekdays() {
    final date = DateTime.now(); // Replace with currentDate.value if needed
    final start = DateTime(date.year, date.month, 1);
    final end = DateTime(date.year, date.month + 1, 0);
    final formatter = DateFormat("dd MMM");

    // Count weekdays
    int weekdayCount = 0;
    for (int i = 0; i <= end.day - 1; i++) {
      final currentDay = DateTime(date.year, date.month, i + 1);
      if (currentDay.weekday != DateTime.saturday && currentDay.weekday != DateTime.sunday) {
        weekdayCount++;
      }
    }

    return "$weekdayCount";
  }

  void updateToggleSelection(int index) {
    toggleSelection[0] = index == 0;
    toggleSelection[1] = index == 1;
    isCalendarView.value = index == 0;
  }
  var isDaywiseView = true.obs;

  // Add your existing logic for fetching event
  var insights = [
    {"title": "Late-in", "days": 1, "date": "06 Mar"},
    {"title": "Early-out", "days": 1, "date": "08 Mar"},
    {"title": "Exception", "days": 2, "date": "10 Mar"},
  ].obs;

  // To manage expanded state of each card
  var expandedCard = {}.obs;
  // List of month names
  final List<String> monthNames = [
    "Jan", "Feb", "Mar", "Apr", "May", "Jun",
    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
  ];

  void goToNextMonth() {
    currentDate.value = DateTime(
      currentDate.value.year,
      currentDate.value.month + 1,
      1,
    );
    // updateAttendance(presentCount: presentCount, absentCount: absentCount, onLeaveCount: onLeaveCount, holidayCount: holidayCount, restDayCount: restDayCount);
    // print("Next Month Range: $currentMonthRange");
    // print("Total Working Days: $currentMonthWorkingDays");

  }

  void goToPreviousMonth() {
    currentDate.value = DateTime(
      currentDate.value.year,
      currentDate.value.month - 1,
      1,
    );
    // updateAttendance(presentCount: presentCount, absentCount: absentCount, onLeaveCount: onLeaveCount, holidayCount: holidayCount, restDayCount: restDayCount);
    //
    // print("Previous Month Range: $currentMonthRange");
    // print("Total Working Days: $currentMonthWorkingDays");

  }
  List<Map<String, String>> getEventsForMonth() {
    // Define the start and end date for the current month
    DateTime now = DateTime.now();
    DateTime firstDay = DateTime(now.year, now.month, 1);
    DateTime lastDay = DateTime(now.year, now.month + 1, 0); // Last day of the month

    List<Map<String, String>> monthlyEvents = [];

    for (DateTime day = firstDay;
    day.isBefore(lastDay.add(Duration(days: 1)));
    day = day.add(Duration(days: 1))) {

      // Fetch attendance details for each day
      List<Map<String, dynamic>> events = getEventsForDay(day);

      if (events.isNotEmpty) {
        monthlyEvents.add({
          'date': "${day.day} ${getMonthName(day.month)}",
          'day': _getWeekdayName(day.weekday),
          'shift': "10:00 AM to 07:00 PM", // Replace with dynamic shift time
          'status': events[0]['status'] ?? '',
          'first_in': events[0]['first_in'] ?? '00:00',
          'last_out': events[0]['last_out'] ?? '00:00',
          'actual_hours': events[0]['actual_hours'] ?? '00:00',
        });
      }
    }

    return monthlyEvents;
  }

  String _getWeekdayName(int weekday) {
    List<String> weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
    return weekdays[weekday - 1];
  }

  static String getMonthName(int month) {
    List<String> months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return months[month - 1];
  }

  // Update Attendance Data
  void updateAttendance({
    required int presentCount,
    required int absentCount,
    required int onLeaveCount,
    required int holidayCount,
    required int restDayCount,
  }) {
    present.value = presentCount;
    absent.value = absentCount;
    onLeave.value = onLeaveCount;
    holiday.value = holidayCount;
    restDay.value = calculateRestDaysInMonth();

  }




  void goToDayDetails(DateTime selectedDate) {
    final events = getEventsForDay(selectedDate);

    if (events.isNotEmpty) {
      final event = events.first; // Taking the first event if multiple exist
      // // Debugging: Print data before passing
      // print("Navigating to DayDetailsView with data:");
      // print("Date: ${selectedDate.day} ${getMonthName(selectedDate.month)}");
      // print("Status: ${event["status"] ?? ""}");
      // print("Shift: ${event["shift"] ?? "Not Available"}");
      // print("First In: ${event["first_in"] ?? "00:00"}");
      // print("Last Out: ${event["last_out"] ?? "00:00"}");
      // print("Actual Hours: ${event["actual_hours"] ?? "00:00"}");

      Get.to(() => DayDetailsView(
        date: "${selectedDate.day} ${getMonthName(selectedDate.month)}",
        status: event["status"] ?? "",
        shift: event["shift"] ?? "Not Available",
        firstIn: event["first_in"] ?? "00:00",
        lastOut: event["last_out"] ?? "00:00",
        actualHours: event["actual_hours"] ?? "00:00",
      ),
      //     arguments: {
      //   "date": "${selectedDate.day} ${getMonthName(selectedDate.month)}",
      //   "status": event["status"] ?? "",
      //   "shift": event["shift"] ?? "Not Available",
      //   "first_in": event["first_in"] ?? "00:00",
      //   "last_out": event["last_out"] ?? "00:00",
      //   "actual_hours": event["actual_hours"] ?? "00:00",
      // }
      );
    } else {
      print("No attendance data found for selected date: $selectedDate");
      Get.to(() => DayDetailsView(
        date: "${selectedDate.day} ${getMonthName(selectedDate.month)}",
        status: "No Data",
        shift: "Not Available",
        firstIn: "00:00",
        lastOut:  "00:00",
        actualHours:  "---",
      ),
      //     arguments: {
      //   "date": "${selectedDate.day} ${getMonthName(selectedDate.month)}",
      //   "status": "No Data",
      //   "shift": "Not Available",
      //   "first_in": "--",
      //   "last_out": "--",
      //   "actual_hours": "--",
      // }
      );
    }
  }



  @override
  void onInit() {

    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      selectedIndex.value = tabController.index;
    });

    for (var insight in insights) {
      expandedCard[insight['title']] = false;
    }
    _loadSampleAttendanceData();

    super.onInit();
  }

  var dailyAttendance = <DateTime, List<Map<String, dynamic>>> {}.obs;
  //
  // get presentCount => null;

  Future<List<DateTime>> fetchHolidayDates() async {

    final token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjE2OC4xLjM4OjgwMDAvYXBpL2xvZ2luIiwiaWF0IjoxNzQ4OTI3MjAzLCJleHAiOjE3NDg5MzQ0MDMsIm5iZiI6MTc0ODkyNzIwMywianRpIjoiYkFnUUVnMkJMVEZ1eHNCcCIsInN1YiI6IlhTUy0wNDc3IiwicHJ2IjoiMzRjNDhmOTlmOTNhZWI3Nzc4YjkyZGEyNWZkNTYyYTI2ODVjYjYyNiJ9.92XS9ZVfZcGEp46i7Izmm3W5qPuSqI_nLj3drM09xNE'; // Replace with your actual token

    final response = await http.get(
      Uri.parse('http://192.168.1.38:8000/api/holidays'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List holidays = jsonDecode(response.body);
      return holidays.map<DateTime>((holiday) {
        final dateStr = holiday['date']; // Must be in 'YYYY-MM-DD' format
        return DateTime.parse(dateStr);
      }).toList();
    } else {
      throw Exception('Failed to load holidays: ${response.statusCode}');
    }

  }

  void _loadSampleAttendanceData() async {
    List<DateTime> holidays = await fetchHolidayDates();
    print('hii manikanta');
    print(holidays);
    // final Map<DateTime, List<Map<String, dynamic>>> attendance = {
    //   DateTime(2025, 3, 4): [
    //     {"status": "P", "shift": "GS", "icon": Icons.check_circle, "color": Colors.green.shade200}
    //   ],
    //   DateTime(2025, 3, 5): [
    //     {"status": "P:CL", "shift": "GS", "icon": Icons.medical_services, "gradient": [Colors.green.shade300, Colors.orange.shade300]}
    //   ],
    //   DateTime(2025, 3, 6): [
    //     {"status": "CL", "shift": "GS", "icon": Icons.check_circle, "color": Colors.orange.shade300}
    //   ],
    //   DateTime(2025, 3, 7): [
    //     {"status": "P:SL", "shift": "GS", "icon": Icons.check_circle, "gradient": [Colors.green.shade300, Colors.pink.shade300]}
    //   ],
    //   DateTime(2025, 3, 10): [
    //     {"status": "SL", "shift": "GS", "icon": Icons.beach_access, "color": Colors.pink.shade200}
    //   ],
    //   DateTime(2025, 3, 18): [
    //     {"status": "", "shift": "GS", "icon": Icons.check_circle, "color": Colors.red.shade300}
    //   ],
    //   DateTime(2025, 3, 20): [
    //     {"status": "", "shift": "GS", "icon": Icons.medical_services, "gradient": [Colors.green.shade300, Colors.red.shade300]}
    //   ],
    //   DateTime(2025, 3, 25): [
    //     {"status": "", "shift": "GS", "icon": Icons.check_circle, "color": Colors.yellow.shade300}
    //   ],
    //   DateTime(2025, 3, 17): [
    //     {"status": "", "shift": "GS", "icon": Icons.check_circle, "gradient": [Colors.green.shade300, Colors.red.shade300]}
    //   ],
    //   DateTime(2025, 3, 31): [
    //     {"status": "", "shift": "GS", "icon": Icons.beach_access, "color": Colors.yellow.shade300}
    //   ],
    //   DateTime(2025, 3, 13): [
    //     {"status": " ", "shift": "GS", "icon": Icons.beach_access, "color": Colors.yellow.shade300}
    //   ],
    //   DateTime(2025, 3, 14): [
    //     {"status": " ", "shift": "GS", "icon": Icons.beach_access, "color": Colors.yellow.shade300}
    //   ],
    // };
    //
    // // Modify status to 'H' if date is in holidays
    // attendance.forEach((date, value) {
    //   bool isHoliday = holidays.any((holidayDate) =>
    //   holidayDate.year == date.year &&
    //       holidayDate.month == date.month &&
    //       holidayDate.day == date.day);
    //
    //   if (isHoliday) {
    //     attendance[date] = [
    //       {
    //         "status": "H",
    //         "shift": "Holiday",
    //         "icon": Icons.beach_access,
    //         "color": Colors.red.shade300,
    //       }
    //     ];
    //   }
    // });
    //
    // dailyAttendance.value = attendance;
    // print('hii parr');
    // print(dailyAttendance.value);
  }

  // Fetch events for a selected day
  List<Map<String, dynamic>> getEventsForDay(DateTime day) {
    return dailyAttendance[DateTime(day.year, day.month, day.day)] ?? [];
  }

  // Toggle card expansion
  void toggleCard(String title) {
    expandedCard[title] = !(expandedCard[title] ?? false);
    update();
  }



@override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
