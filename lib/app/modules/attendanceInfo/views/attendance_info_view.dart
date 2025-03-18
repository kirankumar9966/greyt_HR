import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:greyt_hr/app/modules/explore/views/explore_view.dart';
import 'package:table_calendar/table_calendar.dart';

import '../controllers/attendance_info_controller.dart';

class AttendanceInfoView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final AttendanceInfoController controller =
    Get.put(AttendanceInfoController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Info'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Container(
        color: Colors.grey[100],
        child: Column(
          children: [
            // Month Selection
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  border:
                  Border.all(color: Colors.grey.withOpacity(0.5), width: 1.5),

                ),
                child: Obx(() {
                  return Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon:
                        Icon(Icons.arrow_left, size: 30, color: Colors.black),
                        onPressed: () => controller.goToPreviousMonth(),
                      ),
                      Text(
                        controller.currentMonthYear,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_right,
                            size: 30, color: Colors.black),
                        onPressed: () => controller.goToNextMonth(),
                      ),
                    ],
                  );
                }),
              ),
            ),

            // TabBar
            Container(
              color: Colors.white,
              child: TabBar(
                controller: controller.tabController,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.blue,
                tabs: [
                  Tab(text: "Overview"),
                  Tab(text: "Day Wise"),
                ],
                onTap: (index) {
                  controller.selectedIndex.value = index;
                },
              ),
            ),

            // Expanded TabBarView
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children: [
                  _buildOverviewTab(controller), // Donut Chart
                  _buildDaywiseTab(controller),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildDaywiseListView(AttendanceInfoController controller) {
    return Obx(() {
      final events = controller.getEventsForMonth();
      return ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          final status = event['status'] ?? '';
          final shiftTime = event['shift'] ?? '10:00 AM to 07:00 PM';
          final firstIn = event['first_in'] ?? '00:00';
          final lastOut = event['last_out'] ?? '00:00';
          final actualHours = event['actual_hours'] ?? '00:00';
          final eventDate = event['date'] ?? '';

          // Extract day and month
          List<String> dateParts = eventDate.split(" ");
          int day = int.parse(dateParts[0]); // Extracting day from "04 Mar"
          int month = controller.monthNames.indexOf(dateParts[1]) + 1;

          // Get complete DateTime object
          DateTime selectedDate = DateTime(DateTime.now().year, month, day);

          return GestureDetector(
            onTap: () {
              controller.goToDayDetails(selectedDate);
            },
            child: _buildAttendanceCard(
              date: eventDate,
              day: event['day'] ?? '',
              shiftTime: shiftTime,
              status: status,
              firstIn: firstIn,
              lastOut: lastOut,
              actualHours: actualHours,
            ),
          );
        },
      );
    });
  }




  Widget _buildAttendanceCard({
    required String date,
    required String day,
    required String shiftTime,
    required String status,
    required String firstIn,
    required String lastOut,
    required String actualHours,
  }) {
    Color textColor = Colors.black;
    Color borderColor = Colors.grey.withOpacity(0.3);
    BoxDecoration boxDecoration;

    DateTime now = DateTime.now();
    DateTime currentDate = DateTime(now.year, now.month, now.day);
    DateTime cardDate = DateTime(
      now.year,
      now.month,
      int.parse(date.split(" ")[0]), // Extract day from "04 Mar"
    );

    String todayDate =
        "${now.day.toString().padLeft(2, '0')} ${AttendanceInfoController.getMonthName(now.month)}";

    bool isFuture = cardDate.isAfter(currentDate);
    bool isToday = date == todayDate;

    // ✅ Style Future Days (Greyed-Out)
    if (isFuture) {
      boxDecoration = BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400, width: 1),
      );
    }
    // ✅ Style "Today" with a Blue Border
    else if (isToday) {
      boxDecoration = BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade300, width: 1),
      );
    }
    // ✅ Handle Half-Day (Diagonal Split)
    else if (status.contains(':')) {
      List<String> parts = status.split(':');
      String firstHalf = parts[0]; // Example: "P"
      String secondHalf = parts[1]; // Example: "SL"

      Color firstColor = _getStatusColor(firstHalf);
      Color secondColor = _getStatusColor(secondHalf);

      boxDecoration = BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
        gradient: LinearGradient(
          colors: [firstColor, secondColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      );
    }
    // ✅ Style Normal Statuses
    else {
      boxDecoration = BoxDecoration(
        color: _getStatusColor(status),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: EdgeInsets.all(12),
      decoration: boxDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    date,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textColor),
                  ),
                  // ✅ Show "Today" Badge if Date is Today
                  if (isToday)
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "Today",
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                ],
              ),
              Row(
                children: [
                  Text(
                    status,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: textColor),
                  ),
                  if (status == 'O') // ✅ Show "TV" icon for Off days
                    Icon(Icons.tv, color: Colors.black, size: 20),
                ],
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            "$day  |  $shiftTime",
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
          SizedBox(height: 8),

          // ✅ Show "No Attendance Data" for Future Dates
          if (isFuture)
            Center(
              child: Text(
                "No Attendance Data",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            )
          // ✅ Show Attendance Data for Past Days Only (Not for Today)
          else if (status.isNotEmpty && !isToday)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoColumn("First In", firstIn),
                _buildInfoColumn("Last Out", lastOut),
                _buildInfoColumn("Actual Work Hrs", actualHours),
              ],
            )
          else
            Center(
              child: Text(
                "No Attendance Data",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
        ],
      ),
    );
  }

// ✅ Helper Function to Get Status Color
  Color _getStatusColor(String status) {
    switch (status) {
      case 'P':
        return Colors.green.shade50;
      case 'LOP':
        return Colors.pink.shade50;
      case 'SL':
        return Colors.pink.shade50;
      case 'CL':
        return Colors.pink.shade50;
      case 'H':
        return Colors.blue.shade50;
      case 'A':
        return Colors.grey.shade50;
      case 'O':
        return Colors.blue.shade100;
      default:
        return Colors.white;
    }
  }



  Widget _buildInfoColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
        Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }


  Widget _buildDaywiseTab(AttendanceInfoController controller) {
    return Column(
      children: [
        // Top Bar with Info Icon and Switch View
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.info_outline, color: Colors.blue),
                onPressed: () {
                  Get.defaultDialog(
                    title: "Attendance Info",
                    middleText: "This calendar shows your attendance details.",
                    textConfirm: "OK",
                    confirmTextColor: Colors.white,
                    onConfirm: () => Get.back(),
                  );
                },
              ),
              Obx(() => ToggleButtons(
                borderRadius: BorderRadius.circular(8),
                selectedColor: Colors.white,
                color: Colors.blue,
                fillColor: Colors.blue,
                selectedBorderColor: Colors.blueAccent,
                borderWidth: 1,
                isSelected: [
                  controller.isDaywiseView.value ? true : false,
                  controller.isDaywiseView.value ? false : true
                ],
                onPressed: (index) {
                  controller.isDaywiseView.value = index == 0;
                },
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Icon(Icons.grid_view, size: 20), // Calendar View
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Icon(Icons.list, size: 20), // List View
                  ),
                ],
              )),
            ],
          ),
        ),

        // Switch Between Calendar View & List View
        Expanded(
          child: Obx(() {
            return controller.isDaywiseView.value
                ? _buildCalendarView(controller) // Grid Calendar View
                : _buildDaywiseListView(controller); // List View
          }),
        ),
      ],
    );
  }

  Widget _buildCalendarView(AttendanceInfoController controller) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // Calendar or List View based on isDaywiseView
          Expanded(
            child: Obx(() {
              return Column(
                children: [
                  TableCalendar(
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: controller.currentDate.value,
                    calendarFormat: CalendarFormat.month,
                    selectedDayPredicate: (day) {
                      return isSameDay(controller.currentDate.value, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      controller.currentDate.value = selectedDay;
                      controller.goToDayDetails(selectedDay);

                    },
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: Colors.green.shade500,
                        shape: BoxShape.circle,
                      ),
                      outsideDaysVisible: false,
                    ),
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                    calendarBuilders: CalendarBuilders(
                      defaultBuilder: (context, day, focusedDay) {
                        final events = controller.getEventsForDay(day) ?? [];
                        final isToday = isSameDay(day, DateTime.now());
                        final isSelected = isSameDay(day, controller.currentDate.value);

                        Color bgColor = Colors.transparent;
                        String? statusText;
                        Color textColor = Colors.black;

                        if (events.isNotEmpty) {
                          String status = events[0]['status'];

                          if (status == 'P') {
                            bgColor = Colors.green.shade100;
                            statusText = "P";
                          } else if (status == 'LOP' || status == 'SL' || status == 'CL' || status == 'A') {
                            bgColor = Colors.pink.shade100;
                            statusText = status;
                          } else if (status == 'H') {
                            bgColor = Colors.blueAccent.shade100;
                            statusText = "H";
                          } else if (status.contains(':')) {
                            final statuses = status.split(':');
                            if (statuses.length == 2) {
                              return Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.green.shade100, Colors.pink.shade200],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  shape: BoxShape.rectangle,
                                ),
                                width: 40,
                                height: 50,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      day.day.toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      status,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 2),
                                    Icon(
                                      Icons.circle,
                                      size: 6,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              );
                            }
                          }
                        }

                        if (day.weekday == DateTime.saturday || day.weekday == DateTime.sunday) {
                          bgColor = Colors.blue.shade100;
                          statusText = "O";
                          textColor = Colors.blue;
                        }

                        return Container(
                          width: 40,
                          height: 55,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.blue : bgColor,
                            shape: BoxShape.circle,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                day.day.toString(),
                                style: TextStyle(
                                  color: isSelected ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              if (statusText != null)
                                Text(
                                  statusText,
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 12,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              if (isToday)
                                Icon(
                                  Icons.circle,
                                  size: 6,
                                  color: Colors.black,
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                    eventLoader: (day) => controller.getEventsForDay(day) ?? [],
                  ),

                  // Attendance List View
                  Expanded(
                    child: Obx(() {
                      final events = controller.getEventsForDay(controller.currentDate.value) ?? [];
                      return ListView.builder(
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: EdgeInsets.all(8),
                            child: ListTile(
                              title: Text(events[index]['status'] ?? ''),
                              subtitle: Text(events[index]['shift'] ?? ''),
                              trailing: events[index]['icon'] != null
                                  ? Icon(events[index]['icon'], color: Colors.blue)
                                  : null,
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab(AttendanceInfoController controller) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                border:
                    Border.all(color: Colors.grey.withOpacity(0.5), width: 1.5),
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Summary Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Summary",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "20 ", // Make "20" black
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: "Working days", // Keep "Working days" gray
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    "01 Jan - 31 Jan",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),

                  // Donut Chart Section
                  SizedBox(height: 5),
                  Container(
                    height: 200, // Set a fixed height for the PieChart
                    child: Obx(() => PieChart(
                          PieChartData(
                            sections: _generatePieChartSections(controller),
                            centerSpaceRadius: 50, // Donut Effect
                            sectionsSpace: 3, // Creates a gap between segments
                            startDegreeOffset: 270, // Rotates for better look
                          ),
                        )),
                  ),

                  SizedBox(height: 5),

                  // Attendance Legend Below Donut Chart
                  _buildAttendanceLegend(controller),

                  Divider(thickness: 1, color: Colors.grey.withOpacity(0.3)),

                  // Average Work Hours Section
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Average Work Hours",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "09:36",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "+84%",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.green),
                            ),
                            SizedBox(width: 4),
                            Text(
                              "From Dec",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                border:
                    Border.all(color: Colors.grey.withOpacity(0.5), width: 1.5),
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  _buildInsightsSection(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Insights Section
  Widget _buildInsightsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Insights",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        SizedBox(height: 5),
        Text("01 Mar - 31 Mar",
            style: TextStyle(fontSize: 14, color: Colors.grey)),

        SizedBox(height: 10),

        // Deduction Overview
        _buildDeductionOverview(),

        SizedBox(height: 10),

        // Late-in & Early-out Cards
        _buildDeductionItem("Late-in", "06 Mar", "1 day"),
        _buildDeductionItem2("Early-out", "2 days", ["08 Mar", "09 Mar"]),
        SizedBox(height: 10),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.withOpacity(0.5)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Exception",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text("None",
                    style: TextStyle(fontSize: 12, color: Colors.blue)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Deduction Overview
  Widget _buildDeductionOverview() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Deduction overview",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text("None",
                style: TextStyle(fontSize: 12, color: Colors.blue)),
          ),
        ],
      ),
    );
  }

  // Deduction Item
  Widget _buildDeductionItem(String title, String date, String days) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.red
            .withOpacity(0.1), // Background color for the main container
        borderRadius: BorderRadius.circular(10),
      ),
      child: Theme(
        data: ThemeData(
          dividerColor: Colors.transparent, // Remove default divider line
        ),
        child: ExpansionTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(days,
                    style: TextStyle(fontSize: 12, color: Colors.blue)),
              ),
            ],
          ),
          children: [
            Container(
              color: Colors.grey
                  .withOpacity(0.1), // Background color for expanded area
              child: ListTile(
                leading:
                    Icon(Icons.calendar_today, size: 20, color: Colors.black),
                title: Text(date,
                    style: TextStyle(fontSize: 14, color: Colors.black)),
                trailing:
                    Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeductionItem2(String title, String days, List<String> dates) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1), // Background color for the main container
        borderRadius: BorderRadius.circular(10),
      ),
      child: Theme(
        data: ThemeData(
          dividerColor: Colors.transparent, // Remove default divider line
        ),
        child: ExpansionTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(days,
                    style: TextStyle(fontSize: 12, color: Colors.blue)),
              ),
            ],
          ),
          children: dates.map((date) {
            return GestureDetector(
              onTap: () {
                // Navigate to another page
                Get.to(() => ExploreView(), arguments: {
                  'title': title,
                  'date': date,
                }); // Use GetX navigation

              },
              child: Container(
                color: Colors.grey.withOpacity(0.1), // Background color for expanded area
                child: ListTile(
                  leading: Icon(Icons.calendar_today, size: 20, color: Colors.black),
                  title: Text(date,
                      style: TextStyle(fontSize: 14, color: Colors.black)),
                  trailing:
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // Pie Chart Data
  List<PieChartSectionData> _generatePieChartSections(
      AttendanceInfoController controller) {
    return [
      PieChartSectionData(
        color: Colors.green,
        value: controller.present.value.toDouble(),
        title: '',
        radius: 20,
      ),
      PieChartSectionData(
        color: Colors.red,
        value: controller.absent.value.toDouble(),
        title: '',
        radius: 20,
      ),
      PieChartSectionData(
        color: Colors.purple,
        value: controller.onLeave.value.toDouble(),
        title: '',
        radius: 20,
      ),
      PieChartSectionData(
        color: Colors.blue,
        value: controller.holiday.value.toDouble(),
        title: '',
        radius: 20,
      ),
      PieChartSectionData(
        color: Colors.grey,
        value: controller.restDay.value.toDouble(),
        title: '',
        radius: 20,
      ),
    ];
  }

  // Attendance Legend
  Widget _buildAttendanceLegend(AttendanceInfoController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10), // Add padding if needed
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(), // Disable scrolling in the grid
        shrinkWrap: true, // Ensure it fits within the parent widget
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 items per row
          mainAxisSpacing: 10, // Vertical spacing between rows
          crossAxisSpacing: 10, // Horizontal spacing between items
          childAspectRatio: 2, // Adjust the aspect ratio (width/height) of items
        ),
        itemCount: 5, // Total number of items
        itemBuilder: (context, index) {
          // Map your attendance data dynamically
          final attendanceItems = [
            {"color": Colors.green, "label": "Present", "count": controller.present.value},
            {"color": Colors.red, "label": "Absent", "count": controller.absent.value},
            {"color": Colors.purple, "label": "On Leave", "count": controller.onLeave.value},
            {"color": Colors.blue, "label": "Holiday", "count": controller.holiday.value},
            {"color": Colors.grey, "label": "Rest Day", "count": controller.restDay.value},
          ];

          final item = attendanceItems[index];
          return _buildLegendItem(item["color"] as Color,
                                  item["label"] as String,
                                  item["count"] as int);
        },
      ),
    );
  }

  // Legend Item Row
  Widget _buildLegendItem(Color color, String label, int count) {
    return Column(
      children: [
        Row(
          children: [
            Container(
                width: 8,
                height: 8,
                decoration:
                    BoxDecoration(color: color, shape: BoxShape.circle)),
            SizedBox(width: 5),
            Text(label, style: TextStyle(fontSize: 12, color: Colors.black)),
          ],
        ),
        Text(
          "$count",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
