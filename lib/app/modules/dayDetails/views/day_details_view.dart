import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greyt_hr/app/modules/dashboard/views/dashboard_view.dart';
import '../controllers/day_details_controller.dart';

class DayDetailsView extends GetView<DayDetailsController> {
  final String date;
  final String status;
  final String shift;
  final String firstIn;
  final String lastOut;
  final String actualHours;

  const DayDetailsView({
    this.date = "",
     this.status = "",
     this.shift = "",
     this.firstIn = "",
     this.lastOut = "",
     this.actualHours = "",
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Day Details'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Get.to(DashboardView());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date Navigation
            Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_left),
                    onPressed: () {},
                  ),
                  Text(
                        date,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                  IconButton(
                    icon: const Icon(Icons.arrow_right),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Attendance Status
            Center(
                  child: Text(
                   status,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ),

            const SizedBox(height: 10),

            // Alert Box
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.yellow.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.yellow.shade700),
              ),
              child: Row(
                children: const [
                  Icon(Icons.warning, color: Colors.orange),
                  SizedBox(width: 8),
                  Text("Access Card Details Not Found"),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Shift Timing & Attendance Scheme
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: _buildInfoCard("Shift Timing", "10:00-19:00".obs)),
                  SizedBox(width: 10),
                  Expanded(
                      child: _buildInfoCard(
                          "Attendance Scheme", "10:00 AM to 07:00 PM".obs)),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Processed Time
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Details",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4), // Small
                          Row(children: [
                            Icon(Icons.check_circle, color: Colors.green),
                            SizedBox(width: 5), // Small
                            Text(
                              "Processed on 7th Mar at 06:05 AM",
                              style: TextStyle(color: Colors.black54),
                            ),
                          ])
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10), // Proper spacing after Row

                  // Expandable Sections (moved inside Column)
                  _buildExpandableSection(
                      "Attendance Info", _buildAttendanceInfo()),
                  _buildExpandableSection(
                      "Session Details", _buildSessionDetails()),
                  _buildExpandableSection("Swipes", _buildSwipes(),
                      trailing: "10:15 hrs"),
                ],
              ),
            ),

            SizedBox(height: 10), // Space before new section

            // Status Details Box
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              margin: EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: Colors.white, // Background color
                borderRadius: BorderRadius.circular(8), // Rounded corners
                border: Border.all(color: Colors.grey.shade300), // Light border
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ], // Light shadow for elevation
              ),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // Aligns text & status
                children: [
                  Text(
                    "Status Details",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50, // Light blue background
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      "Not applied",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, RxString value) {
    return Obx(() => Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 14, color: Colors.grey)),
              SizedBox(height: 4),
              Text(value.value,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            ],
          ),
        ));
  }

  Widget _buildAttendanceInfo() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRow("First In", "10:19", "Last Out", "20:34"),
          _buildRow("Late In", "00:19", "Early Out", "--"),
          _buildRow("Total Work Hrs", "10:15", "Break Hrs", "--"),
          _buildRow(
              "Actual Work Hrs", "10:15", "Work Hours in Shift Time", "09:00"),
          _buildRow("Shortfall Hrs", "--", "Excess Hrs", "01:15"),
        ],
      ),
    );
  }

  Widget _buildSessionDetails() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Session 1", style: TextStyle(fontWeight: FontWeight.bold)),
          _buildRow("10:00 - 14:00", "", "First In Time", "10:19"),
          _buildRow("", "", "Last Out Time", "--"),
          Divider(),
          Text("Session 2", style: TextStyle(fontWeight: FontWeight.bold)),
          _buildRow("14:01 - 19:00", "", "First In Time", "--"),
          _buildRow("", "", "Last Out Time", "20:34"),
        ],
      ),
    );
  }

  Widget _buildSwipes() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRow("Actual Hours", "10:15", "", ""),
          _buildRow("IN", "10:19:47", "Location", "Mobile Sign In"),
          _buildRow("", "06 Mar 2025", "", "More Info"),
          Divider(),
          _buildRow("OUT", "20:34:59", "Location", "--"),
          _buildRow("", "06 Mar 2025", "", "More Info"),
        ],
      ),
    );
  }

  Widget _buildExpandableSection(String title, Widget content,
      {String? trailing}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightBlue.shade50, // Light blue background
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
        border: Border.all(color: Colors.grey, width: 1), // Blue border
      ),
      margin: EdgeInsets.symmetric(
          vertical: 5, horizontal: 10), // Margin for spacing
      child: ExpansionTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        trailing: trailing != null ? Text(trailing) : null,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String leftTitle, String leftValue, String rightTitle,
      String rightValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: _buildColumn(leftTitle, leftValue)),
          Expanded(child: _buildColumn(rightTitle, rightValue)),
        ],
      ),
    );
  }

  Widget _buildColumn(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 12, color: Colors.grey)),
        Text(value,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
