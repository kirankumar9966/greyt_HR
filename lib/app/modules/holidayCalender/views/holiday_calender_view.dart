import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../dashboard/models/HolidayCalender.dart';
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
          Container(
            color: Colors.lightBlueAccent.withOpacity(0.1),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => DropdownButton<int>(
                  value: controller.selectedYear.value,
                  onChanged: (year) => controller.updateYear(year!),
                  items: [2025, 2026, 2027, 2028].map((year) {
                    return DropdownMenuItem<int>(
                      value: year,
                      child: Text(
                        "$year",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList(),
                )),
                Obx(() => DropdownButton<String>(
                  value: controller.selectedHolidayType.value,
                  onChanged: (type) => controller.updateHolidayType(type!),
                  items: ["All Holidays", "General Holidays"].map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(
                        type,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList(),
                )),
              ],
            ),
          ),

          // Holiday List
          Expanded(
            child: Obx(() {
              if (controller.filteredHolidays.isEmpty) {
                return const Center(child: Text("🎉 No upcoming holidays found"));
              }

              final grouped = _groupByMonth(controller.filteredHolidays);

              return ListView.builder(
                itemCount: grouped.keys.length,
                itemBuilder: (context, index) {
                  final month = grouped.keys.elementAt(index);
                  final holidaysInMonth = grouped[month]!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Text(
                          "$month ${controller.selectedYear.value}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                      ),

                      ...holidaysInMonth.map((holiday) => _buildHolidayCard(holiday)).toList(),
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

  Map<String, List<Holiday>> _groupByMonth(List<Holiday> holidays) {
    final Map<String, List<Holiday>> map = {};
    for (var h in holidays) {
      final parsedDate = DateTime.tryParse(h.date);
      final month = parsedDate != null ? DateFormat('MMMM').format(parsedDate) : "Unknown";
      map.putIfAbsent(month, () => []);
      map[month]!.add(h);
    }
    return map;
  }

  Widget _buildHolidayCard(Holiday holiday) {
    final parsedDate = DateTime.tryParse(holiday.date);
    final date = parsedDate != null ? DateFormat('dd').format(parsedDate) : '??';
    final day = holiday.day;
    final name = holiday.festival;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.lightBlueAccent, Colors.grey],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 25,
          child: Text(
            date,
            style: const TextStyle(
              color: Colors.lightBlueAccent,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          day,
          style: const TextStyle(color: Colors.white70),
        ),
        trailing: const Icon(Icons.celebration, color: Colors.white),
      ),
    );
  }
}
