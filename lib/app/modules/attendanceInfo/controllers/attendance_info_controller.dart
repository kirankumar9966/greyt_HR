import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../dayDetails/controllers/day_details_controller.dart';
import '../../dayDetails/views/day_details_view.dart';

class AttendanceInfoController extends GetxController with GetTickerProviderStateMixin {
  var currentDate = DateTime.now().obs;
  late TabController tabController;
  var selectedIndex = 0.obs;

  var toggleSelection = [true, false].obs; // Default to calendar view
  var isCalendarView = true.obs; // Tracks the current view
// Attendance Data
  var present = 12.obs;
  var absent = 1.obs;
  var onLeave = 2.obs;
  var holiday = 2.obs;
  var restDay = 13.obs;
  // Getter for formatted month and year (e.g., Mar'25)
  String get currentMonthYear {
    return "${monthNames[currentDate.value.month - 1]}'${currentDate.value.year % 100}";
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

  void goToPreviousMonth() {
    currentDate.value = DateTime(
      currentDate.value.year,
      currentDate.value.month - 1,
      1,
    );
  }

  void goToNextMonth() {
    currentDate.value = DateTime(
      currentDate.value.year,
      currentDate.value.month + 1,
      1,
    );
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
    restDay.value = restDayCount;
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


  void _loadSampleAttendanceData() {
    dailyAttendance.value = {
      DateTime(2025, 3, 4): [
        {"status": "P", "shift": "GS", "icon": Icons.check_circle, "color": Colors.green.shade200}
      ],
      DateTime(2025, 3, 5): [
        {"status": "P:CL", "shift": "GS", "icon": Icons.medical_services, "gradient": [Colors.green.shade300, Colors.orange.shade300]}
      ],
      DateTime(2025, 3, 6): [
        {"status": "CL", "shift": "GS", "icon": Icons.check_circle, "color": Colors.orange.shade300}
      ],
      DateTime(2025, 3, 7): [
        {"status": "P:SL", "shift": "GS", "icon": Icons.check_circle, "gradient": [Colors.green.shade300, Colors.pink.shade300]}
      ],
      DateTime(2025, 3, 10): [
        {"status": "SL", "shift": "GS", "icon": Icons.beach_access, "color": Colors.pink.shade200}
      ],
      DateTime(2025, 3, 18): [
        {"status": "", "shift": "GS", "icon": Icons.check_circle, "color": Colors.red.shade300}
      ],
      DateTime(2025, 3, 20): [
        {"status": "", "shift": "GS", "icon": Icons.medical_services, "gradient": [Colors.green.shade300, Colors.red.shade300]}
      ],
      DateTime(2025, 3, 25): [
        {"status": "", "shift": "GS", "icon": Icons.check_circle, "color": Colors.yellow.shade300}
      ],
      DateTime(2025, 3, 17): [
        {"status": "", "shift": "GS", "icon": Icons.check_circle, "gradient": [Colors.green.shade300, Colors.red.shade300]}
      ],
      DateTime(2025, 3, 31): [
        {"status": "", "shift": "GS", "icon": Icons.beach_access, "color": Colors.yellow.shade300}
      ],
      DateTime(2025, 3, 13): [
        {"status": " ", "shift": "GS", "icon": Icons.beach_access, "color": Colors.yellow.shade300}
      ],
      DateTime(2025, 3, 14): [
        {"status": " ", "shift": "GS", "icon": Icons.beach_access, "color": Colors.yellow.shade300}
      ],
    };

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
