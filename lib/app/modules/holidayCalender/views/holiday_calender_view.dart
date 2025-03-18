import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/holiday_calender_controller.dart';

class HolidayCalenderView extends GetView<HolidayCalenderController> {
  const HolidayCalenderView({super.key});

  @override
  Widget build(BuildContext context) {
    final HolidayCalenderController controller = Get.put(HolidayCalenderController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Holiday Calendar'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Dropdowns for Year & Holiday Type Selection
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Year Selection Dropdown
                Obx(() => DropdownButton<int>(
                  value: controller.selectedYear.value,
                  onChanged: (year) => controller.updateYear(year!),
                  items: [2025, 2026, 2027, 2028].map((year) {
                    return DropdownMenuItem<int>(
                      value: year,
                      child: Text("$year"),
                    );
                  }).toList(),
                )),

                // Holiday Type Dropdown
                Obx(() => DropdownButton<String>(
                  value: controller.selectedHolidayType.value,
                  onChanged: (type) => controller.updateHolidayType(type!),
                  items: ["All Holidays", "General Holidays"].map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                )),
              ],
            ),
          ),

          // Holiday List
          Expanded(
            child: Obx(() {
              var groupedHolidays = _groupHolidaysByMonth(controller.filteredHolidays);

              return ListView.builder(
                itemCount: groupedHolidays.keys.length,
                itemBuilder: (context, index) {
                  String month = groupedHolidays.keys.elementAt(index);
                  List<Map<String, dynamic>> monthHolidays = groupedHolidays[month]!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Month Header
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                          "$month ${controller.selectedYear.value}",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),

                      // Holiday Cards or "No Holidays" Message
                      monthHolidays.isEmpty
                          ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "No holidays to show!",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      )
                          : Column(
                        children: monthHolidays.map((holiday) {
                          return _buildHolidayCard(
                            holiday["date"],
                            holiday["day"],
                            holiday["name"],
                          );
                        }).toList(),
                      ),
                    ],
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  // Helper Function: Group Holidays by Month
  Map<String, List<Map<String, dynamic>>> _groupHolidaysByMonth(
      List<Map<String, dynamic>> holidays) {
    Map<String, List<Map<String, dynamic>>> groupedHolidays = {};
    for (var holiday in holidays) {
      String month = holiday["month"];
      if (!groupedHolidays.containsKey(month)) {
        groupedHolidays[month] = [];
      }
      groupedHolidays[month]!.add(holiday);
    }
    return groupedHolidays;
  }

  // Holiday Card Widget
  Widget _buildHolidayCard(String date, String day, String name) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Date Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                date,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                day,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
          SizedBox(width: 12),

          // Holiday Name
          Expanded(
            child: Text(
              name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
