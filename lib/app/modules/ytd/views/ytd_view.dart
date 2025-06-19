import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/ytd_controller.dart';
import '../controllers/ytd_controller.dart' as controller;

class YtdView extends GetView<YtdController> {
  const YtdView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('YtdReports')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildCard(
              title: 'YTD Statement',
              onViewMore: () => Get.to(() => const YtdDetailView()),
              onDownload: controller.downloadYTD,
            ),
            const SizedBox(height: 16),
            _buildCard(
              title: 'PFYTD Statement',
              onViewMore: () => Get.to(() => const PfytdDetailTabView()),
              onDownload: controller.downloadPFYTD,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required VoidCallback onViewMore,
    required VoidCallback onDownload,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(onPressed: onViewMore, child: const Text('View More')),
                ElevatedButton(
                  onPressed: onDownload,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text('Download'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class YtdDetailView extends StatelessWidget {
  const YtdDetailView({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('YTD Statement'),
        leading: const BackButton(),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.home_outlined),
          )
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dropdown Year Range
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE9F0FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Apr 2024 - Mar 2025',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Info Banner
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3E0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Statement generated as on February 2025',
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Cards
                _buildStatCard('Income', '₹4,25,424.00'),
                const SizedBox(height: 16),
                _buildStatCard('Deductions', '₹28,612.00'),
                const SizedBox(height: 16),
                _buildStatCard('Days', '330.00'),
                const SizedBox(height: 100), // space for floating button
              ],
            ),
          ),

          // Floating Download Button
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: ElevatedButton.icon(
              onPressed: controller.downloadYTD,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3D5CFF),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 6,
              ),
              icon: const Icon(Icons.download, color: Colors.white),
              label: const Text(
                'Download YTD Statement',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 4,
            offset: Offset(1, 2),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Title and Amount
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF4A5A75)),
              ),
            ],
          ),
          // Badge & Arrow
          Column(
            children: [
              const CircleAvatar(
                radius: 10,
                backgroundColor: Color(0xFF64D2B1),
              ),
              const SizedBox(height: 20),
              Row(
                children: const [
                  Icon(Icons.arrow_forward, size: 20),
                  SizedBox(width: 4),
                  CircleAvatar(radius: 4, backgroundColor: Colors.pinkAccent),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class PfytdDetailTabView extends GetView<YtdController> {
  const PfytdDetailTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('PFYTD Statement'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Summary'),
              Tab(text: 'Detailed View'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            SummaryTab(),
            DetailedViewTab(),
          ],
        ),
      ),
    );
  }
}

class SummaryTab extends StatelessWidget {
  const SummaryTab({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GetBuilder<YtdController>(
          builder: (_) => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dropdown area
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(controller.months[controller.selectedMonth.value]),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Orange strip
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Statement generated as on ${controller.generatedMonth.value}',
                    style: const TextStyle(
                        color: Colors.orange, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 12),

                // PF Summary Box
                Container(
                  width: double.infinity,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(0, 3))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Your PF Summary Stateme...",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 10),
                      Text(
                        '₹${controller.totalAmount.value}',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Employee Details
                Container(
                  width: double.infinity,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Employee Details",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 10),
                      buildDetailRow("Employee No", controller.employeeNo.value),
                      buildDetailRow("Name", controller.employeeName.value),
                      buildDetailRow("Join Date", controller.joinDate.value),
                      buildDetailRow("PF Number", controller.pfNumber.value),
                      buildDetailRow("UAN", controller.uan.value),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Download Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: controller.downloadStatement,
                    icon: const Icon(Icons.download),
                    label: const Text('Download PF YTD Statement'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            )),
        const SizedBox(height: 2),
        Text(value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            )),
      ]),
    );
  }
}

class DetailedViewTab extends StatelessWidget {
  const DetailedViewTab({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(


      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Dropdown + months
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: const [
                          Text('Apr 2024 - Mar 2025'),
                          Icon(Icons.arrow_drop_down)
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: const [
                            MonthChip(label: "May"),
                            MonthChip(label: "Jun"),
                            MonthChip(label: "Jul"),
                            MonthChip(label: "Aug"),
                            MonthChip(label: "Sep"),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),

                // Total Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Total",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 4),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text("2,47,426.00",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                      const Divider(),
                      const SizedBox(height: 8),
                      const Text("Employee Contribution",
                          style: TextStyle(color: Colors.grey)),
                      detailLine("PF", "27,696.00"),
                      detailLine("VPF", "0"),
                      const SizedBox(height: 8),
                      const Text("Employer's Contribution",
                          style: TextStyle(color: Colors.grey)),
                      detailLine("PF", "27,696.00"),
                      detailLine("Pension Fund", "0"),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Employee Details
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Employee Details",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 10),
                      detailRow("Employee No", "XSS-0372"),
                      detailRow("Name", "PADMAVATHI VYDA"),
                      detailRow("Join Date", "19 Apr 2021"),
                      detailRow("PF Number", "AP/HYD/0056226/000/0010185"),
                    ],
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),

          // Floating Download Button
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: ElevatedButton.icon(
              onPressed: () {
                // Download logic here
              },
              icon: const Icon(Icons.download),
              label: const Text("Download PF YTD Statement"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            )),
        const SizedBox(height: 2),
        Text(value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            )),
      ]),
    );
  }

  static Widget detailLine(String label, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          Text(amount, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}

class MonthChip extends StatelessWidget {
  final String label;
  const MonthChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Text(label),
    );
  }
}
