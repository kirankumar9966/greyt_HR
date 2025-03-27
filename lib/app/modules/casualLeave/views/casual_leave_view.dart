import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/casual_leave_controller.dart';

class CasualLeaveView extends GetView<CasualLeaveController> {
  const CasualLeaveView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Two tabs: Balance & Transactions
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Casual Leave',

          ),
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white, // Set AppBar background color
          iconTheme: const IconThemeData(color: Colors.black),  // Ensure icons are visible
          bottom: TabBar(
            labelColor: Colors.grey, // Active tab text color
            unselectedLabelColor: Colors.grey, // Inactive tab text color
            indicatorColor: Colors.blue, // Active tab underline color
            indicatorWeight: 3, // Thickness of the indicator

            tabs: const [
              Tab(text: "Balance"),
              Tab(text: "Transactions"),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            _buildBalanceTab(),
            _buildTransactionsTab(),
          ],
        ),
      ),
    );
  }


  Widget _buildBalanceTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDropdown(),
            const SizedBox(height: 16),
            _buildBalanceCard(),
            const SizedBox(height: 16),
            _buildCasualLeaveBarChart(), // Add the new chart here
            const SizedBox(height: 16),
            Obx(() => _buildMonthDetails()), // Update details dynamically
          ],
        ),
      ),
    );
  }


  Widget _buildCasualLeaveBarChart() {
    return SizedBox(
      height: 400,
      child: BarChart(
        BarChartData(
          barGroups: List.generate(
            12,
                (index) => BarChartGroupData(
              x: index,
              barRods: [
                // 🔴 Consumed Leave (Red)
                BarChartRodData(
                  toY: controller.consumed[index],
                  width: 10,
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(5),
                ),
                // 🔵 Leave Balance (Blue)
                BarChartRodData(
                  toY: controller.balance[index],
                  width: 10,
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
              ],
            ),
          ),

          /// **✅ Y-Axis: Months**
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  int index = value.toInt();
                  if (index >= 0 && index < controller.months.length) {
                    return Text(controller.months[index], style: const TextStyle(fontSize: 12));
                  }
                  return const SizedBox();
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  return Text(value.toString(), style: const TextStyle(fontSize: 12));
                },
              ),
            ),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),

          /// **✅ Enable Click to Update Month Details**
          barTouchData: BarTouchData(
            touchCallback: (event, response) {
              if (response != null && response.spot != null) {
                controller.updateSelectedMonth(response.spot!.touchedBarGroupIndex);
              }
            },
            touchTooltipData: BarTouchTooltipData(
              // tooltipBgColor: Colors.black54,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  "${controller.months[groupIndex]}\nConsumed: ${controller.consumed[groupIndex].abs()} | Balance: ${controller.balance[groupIndex]}",
                  const TextStyle(color: Colors.white),
                );
              },
            ),
          ),

          gridData: FlGridData(show: true),
          borderData: FlBorderData(show: false),

          /// **✅ Set X-Axis from Negative to Positive**
            // Maximum range for balance
        ),
      ),
    );
  }

  /// **✅ Month Details Below the Chart**
  Widget _buildMonthDetails() {
    int index = controller.selectedMonthIndex.value;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Month: ${controller.months[index]}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Balance", style: TextStyle(fontSize: 14)),
                Text("${controller.balance[index]}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Opening Balance", style: TextStyle(fontSize: 14)),
                Text("${controller.openingBalance[index]}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Granted", style: TextStyle(fontSize: 14)),
                Text("${controller.granted[index]}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }




// **Method to Display Month Details**




  Widget _buildDropdown() {
    return Container(
      width: 250,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey),
      ),
      child: DropdownButton<String>(
        value: "Jan 2025 - Dec 2025" ,
        isExpanded: true,
        underline: const SizedBox(),
        onChanged: (value) {},
        items: const [
          DropdownMenuItem(
            value: "Jan 2025 - Dec 2025",
            child: Text("Jan 2025 - Dec 2025"),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBalanceRow("Available Balance", "5.5 Days", bold: true),
            Divider(),
            _buildBalanceRow("Opening Balance", "0"),
            _buildBalanceRow("Granted", "7"),
            _buildBalanceRow("Availed", "1.5"),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceRow(String title, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: bold ? FontWeight.bold : FontWeight.normal),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: bold ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTransactionDropdown(),
          const SizedBox(height: 16),
          _buildApplyFilterButton(),
          const SizedBox(height: 16),
          _buildTransactionsCard(),

        ],
      ),
    );
  }

  Widget _buildTransactionDropdown() {
    return Container(
      width: 250,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey),
      ),
      child: DropdownButton<String>(
        value: "Jan 2025 - Dec 2025",
        isExpanded: true,
        underline: const SizedBox(),
        onChanged: (value) {},
        items: const [
          DropdownMenuItem(
            value: "Jan 2025 - Dec 2025",
            child: Text("Jan 2025 - Dec 2025"),
          ),
        ],
      ),
    );
  }

  Widget _buildApplyFilterButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {}, // Add filter logic
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          side: const BorderSide(color: Colors.grey),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        child: const Text("Apply Filter", style: TextStyle(color: Colors.black)),
      ),
    );
  }

  Widget _buildTransactionsCard() {
    return Container(
     decoration: BoxDecoration(
       color: Colors.white,
       borderRadius: BorderRadius.circular(10),
       border: Border.all(width: 1,color: Colors.grey)
     ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Leave Transactions", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildTransactionSection(
              title: "Granted",
              postedOn: "12 Mar 2025",
              from: "01 Jan 2025",
              to: "31 Dec 2025",
              days: "07",
              expiry: "-",
            ),
            const SizedBox(height: 10),
            _buildTransactionSection(
              title: "Availed",
              postedOn: "12 Mar 2025",
              from: "12 Mar 2025",
              to: "12 Mar 2025",
              days: "-0.5",
              expiry: "-",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionSection({
    required String title,
    required String postedOn,
    required String from,
    required String to,
    required String days,
    required String expiry,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 5),
        _buildTransactionRow("Posted On", postedOn),
        _buildTransactionRow("From", from),
        _buildTransactionRow("To", to),
        _buildTransactionRow("Day(s)", days),
        _buildTransactionRow("Expiry", expiry),
      ],
    );
  }

  Widget _buildTransactionRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          Text(value, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

}
