import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/statement_controller.dart';

class StatementView extends GetView<StatementController> {
  const StatementView({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('StatementView'),
//         centerTitle: true,
//       ),
//       body: const Center(
//         child: Text(
//           'StatementView is working',
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//     );
//   }
// }
  //const ITStatementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("IT Statement"),
        leading: const BackButton(),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Obx(() => Row(
            children: [
              tabBarButton("Summary", 0),
              tabBarButton("Detailed view", 1),
            ],
          )),
        ),
      ),
      body: Obx(() => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    controller.taxRegime.value.toUpperCase(),
                    style: const TextStyle(color: Colors.green),
                  ),
                  backgroundColor: Colors.green.withOpacity(0.1),
                ),
                DropdownButton<String>(
                  value: controller.month.value,
                  items: ['Jan 2025', 'Feb 2025']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) controller.month.value = value;
                  },
                ),
              ],
            ),
          ),

          // Tabs
          Expanded(
            child: controller.selectedTabIndex.value == 0
                ? buildSummaryView()
                : buildDetailedView(),
          ),
        ],
      )),
    );
  }

  Widget tabBarButton(String text, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.onTabChange(index),
        child: Container(
          alignment: Alignment.center,
          height: 48,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: controller.selectedTabIndex.value == index
                    ? Colors.blue
                    : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: controller.selectedTabIndex.value == index
                  ? Colors.black
                  : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // Summary View
  Widget buildSummaryView() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        buildSimpleCard("Taxable Income", "₹${controller.taxableIncome.value.toStringAsFixed(2)}"),
        buildSimpleCard("Annual Tax", "₹${controller.annualTax.value.toStringAsFixed(2)}"),
        buildSimpleCard("Total Paid till date", "₹${controller.totalPaid.value.toStringAsFixed(2)}"),
        buildSimpleCard("Remaining Tax To be deducted", "₹${controller.totalPaid.value.toStringAsFixed(2)}"),
        buildSimpleCard("Tax Deductable Per Month", "₹${controller.totalPaid.value.toStringAsFixed(2)}"),
        buildSimpleCard("Remaining Months", "₹${controller.totalPaid.value.toStringAsFixed(2)}"),

        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: controller.onDownloadTap,
          icon: const Icon(Icons.download),
          label: const Text("Download IT Statement"),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
        )
      ],
    );
  }

  // Detailed View
  Widget buildDetailedView() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        buildTappableCard("Income", controller.income.value, "A"),
        buildTappableCard("Deduction", controller.deduction.value, "B"),
        buildTappableCard("Perquisites", controller.perquisites.value, "C"),
        //buildTappableCard("IncomeExcludedfromTax", controller.incomeexcludedfromtax.value, "D"),
        buildTappableCard("Grossalary", controller.grosssalary.value, "E"),

        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: controller.onDownloadTap,
          icon: const Icon(Icons.download),
          label: const Text("Download IT Statement"),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
        )
      ],
    );
  }

  Widget buildSimpleCard(String title, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(title),
        subtitle: Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget buildTappableCard(String title, double amount, String label) {
    return GestureDetector(
      onTap: () => controller.onCardTap(label),
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          title: Text(title),
          subtitle: Text("₹${amount.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}

