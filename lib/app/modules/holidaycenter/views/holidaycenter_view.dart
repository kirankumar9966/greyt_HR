// import 'package:flutter/material.dart';
//
// import 'package:get/get.dart';
//
// import '../controllers/holidaycenter_controller.dart';
//
// class HolidaycenterView extends GetView<HolidaycenterController> {
//   const HolidaycenterView({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('HolidaycenterView'),
//         centerTitle: true,
//       ),
//       body: const Center(
//         child: Text(
//           'HolidaycenterView is working',
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/holidaycenter_controller.dart';

class HolidaycenterView extends GetView<HolidaycenterController> {
  const HolidaycenterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Holiday Calendar")),
      body: Obx(() => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(child: _buildDropdown("All Holidays", controller.categoryOptions, controller.selectedCategory.value, controller.setCategory)),
                const SizedBox(width: 8),
                Expanded(child: _buildDropdown("Year", controller.yearOptions, controller.selectedYear.value, controller.setYear)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 12,
              itemBuilder: (_, index) {
                int month = index + 1;
                var monthHolidays = controller.holidaysForMonth(month);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('MMM yyyy').format(DateTime(controller.extractYear(controller.selectedYear.value), month)),
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      if (monthHolidays.isEmpty)
                        _noHolidayCard()
                      else
                        ...monthHolidays.map((holiday) => _holidayCard(holiday)).toList(),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      )),
    );
  }

  Widget _buildDropdown(String label, List<String> items, String selected, void Function(String) onChanged) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButton<String>(
        isExpanded: true,
        underline: const SizedBox(),
        value: selected,
        items: items.map((String val) => DropdownMenuItem(value: val, child: Text(val))).toList(),
        onChanged: (val) {
          if (val != null) onChanged(val);
        },
      ),
    );
  }

  Widget _holidayCard(HolidayModel holiday) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Column(
              children: [
                Text(DateFormat('dd').format(holiday.date), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                Text(DateFormat('E').format(holiday.date)),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(child: Text(holiday.title, style: const TextStyle(fontSize: 16))),
          ],
        ),
      ),
    );
  }

  Widget _noHolidayCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: const Text("No holidays to show!", style: TextStyle(color: Colors.black54)),
    );
  }
}
