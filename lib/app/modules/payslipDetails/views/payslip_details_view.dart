import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart'; // For asset image loading
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import '../controllers/payslip_details_controller.dart';

class PayslipDetailsView extends GetView<PayslipDetailsController> {
  const PayslipDetailsView({super.key});

  Future<void> generatePayslipPDF() async {
    final pdf = pw.Document();

    // Load Company Logo
    final ByteData logoData = await rootBundle.load('assets/images/Xsilica.png');
    final Uint8List logoBytes = logoData.buffer.asUint8List();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(10),
        build: (pw.Context context) {
          return pw.Container(
            padding: pw.EdgeInsets.all(10),
            decoration: pw.BoxDecoration(border: pw.Border.all(width: 1)),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Company Header with Logo
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Image(pw.MemoryImage(logoBytes), width: 80, height: 80),
                    pw.SizedBox(width: 10),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "XSILICA SOFTWARE SOLUTIONS P LTD",
                          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
                        ),
                        pw.Text(
                          "3rd Floor, Unit No.4, Kapil Kavuri Hub IT Block, Hyderabad, Telangana, India",
                          style: pw.TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 5),
                pw.Divider(thickness: 1),

                // Payslip Title
                pw.Center(
                  child: pw.Text(
                    "Payslip for the month of February 2025",
                    style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.SizedBox(height: 10),

                // Employee Details Table
                pw.Container(
                  decoration: pw.BoxDecoration(border: pw.Border.all(width: 1)),
                  child: _buildEmployeeDetailsTable(),
                ),
                pw.SizedBox(height: 10),

                // Earnings & Deductions Table
                pw.Container(
                  decoration: pw.BoxDecoration(border: pw.Border.all(width: 1)),
                  child: _buildEarningsDeductionsTable(),
                ),
                pw.SizedBox(height: 10),

                // Net Pay Section (Highlighted Box)
                pw.Container(
                  decoration: pw.BoxDecoration(border: pw.Border.all(width: 2)),
                  padding: pw.EdgeInsets.all(5),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        "Net Pay for the month ( Total Earnings - Total Deductions ):",
                        style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(
                        "₹ 19,445",
                        style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 5),
                pw.Text(
                  "(Rupees Nineteen Thousand Four Hundred Forty Five Only)",
                  style: pw.TextStyle(fontSize: 10, fontStyle: pw.FontStyle.italic),
                ),
                pw.SizedBox(height: 10),

                // Footer
                pw.Center(
                  child: pw.Text(
                    "This is a system-generated payslip and does not require a signature.",
                    style: pw.TextStyle(fontSize: 8, fontStyle: pw.FontStyle.italic),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    // Generate a unique file name using timestamp
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String fileName = "Payslip_Feb2025_$timestamp.pdf";

    void _showDownloadMessage(String message) {
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT, // Duration: SHORT or LONG
        gravity: ToastGravity.BOTTOM, // Position: TOP, CENTER, or BOTTOM
        backgroundColor: Colors.green, // Background color of the toast
        textColor: Colors.white, // Text color
        fontSize: 16.0, // Font size
      );
    }

    // Save PDF
    if (await requestStoragePermission()) {
      final directory = Directory("/storage/emulated/0/Download");
      final filePath = "${directory.path}/$fileName";
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      _showDownloadMessage("Download Complete: Payslip saved to $filePath");

      OpenFile.open(filePath);

    } else {
      Get.snackbar("Permission Denied", "Allow storage access in settings", snackPosition: SnackPosition.BOTTOM);
    }
  }


  Future<bool> requestStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      return true;
    }
    if (await Permission.manageExternalStorage.request().isGranted) {
      return true;
    }
    return false;
  }

  pw.Widget _buildEmployeeDetailsTable() {
    return pw.Table(
      border: pw.TableBorder.all(),
      children: [
        _buildTableRow(["Name:", "Obula Kiran Kumar", "Employee No:", "XSS-0474"]),
        _buildTableRow(["Joining Date:", "02 Jan 2023", "Bank Name:", "ICICI"]),
        _buildTableRow(["Designation:", "Software Engineer", "Bank Account No:", "067401005433"]),
        _buildTableRow(["PAN Number:", "LAAPK2826H", "PF No:", "APHYD00562260000010288"]),
        _buildTableRow(["PF UAN:", "101902552104", "", ""]),
      ],
    );
  }

  pw.Widget _buildEarningsDeductionsTable() {
    return pw.Table(
      border: pw.TableBorder.all(),
      children: [
        _buildTableRow(["Earnings", "Full", "Actual", "Deductions", "Actual"], bold: true),
        _buildTableRow(["BASIC", "8762", "8762", "PF", "1051"]),
        _buildTableRow(["HRA", "3505", "3505", "ESI", "157"]),
        _buildTableRow(["CONVEYANCE", "1600", "1600", "PROF TAX", "200"]),
        _buildTableRow(["MEDICAL ALLOWANCE", "1250", "1250", "", ""]),
        _buildTableRow(["SPECIAL ALLOWANCE", "5736", "5736", "", ""]),
        _buildTableRow(["Total Earnings: INR", "20853", "20853", "Total Deductions: INR", "1408"], bold: true),
      ],
    );
  }


  pw.TableRow _buildTableRow(List<String> cells, {bool bold = false}) {
    return pw.TableRow(
      children: cells.map((text) => _buildTableCell(text, bold: bold)).toList(),
    );
  }

  pw.Widget _buildTableCell(String text, {bool bold = false}) {
    return pw.Padding(
      padding: pw.EdgeInsets.all(5),
      child: pw.Text(
        text,
        style: pw.TextStyle(fontSize: 10, fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PayslipDetailsController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payslip Details'),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              color: Colors.grey[50],
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  // Year Dropdown & Horizontal Scrollable Month Selector
                  Container(
                    color: Colors.blue.shade50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          // Year Dropdown
                          Obx(() => DropdownButton<String>(
                                value: controller.selectedYear.value,
                                items: controller.years.map((String year) {
                                  return DropdownMenuItem<String>(
                                    value: year,
                                    child: Text(year,
                                        style: const TextStyle(fontSize: 14)),
                                  );
                                }).toList(),
                                onChanged: (newYear) {
                                  if (newYear != null) {
                                    controller.updateYear(newYear);
                                  }
                                },
                              )),

                          const SizedBox(width: 10),

                          // Horizontal Month Selector
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              child: Obx(
                                () => ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller
                                      .months.length, // ✅ Now this is reactive
                                  itemBuilder: (context, index) {
                                    String month = controller.months[
                                        index]; // ✅ Reactive list access
                                    bool isSelected = month ==
                                        controller.selectedMonth
                                            .value; // ✅ This now correctly checks selection

                                    return GestureDetector(
                                      onTap: () => controller.updateMonth(
                                          month), // ✅ Update selected month
                                      child: AnimatedContainer(
                                        duration: const Duration(
                                            milliseconds:
                                                200), // ✅ Smooth transition effect
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? Colors.pink.shade700
                                              : Colors
                                                  .white, // ✅ Highlight if selected
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: isSelected
                                                ? Colors.pink.shade700
                                                : Colors
                                                    .blueGrey, // ✅ Change border color
                                            width: isSelected
                                                ? 2
                                                : 1, // ✅ Slightly thicker border when selected
                                          ),
                                        ),
                                        child: Text(
                                          month,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: isSelected
                                                ? Colors.white
                                                : Colors
                                                    .black, // ✅ Text color changes
                                            fontWeight: isSelected
                                                ? FontWeight.bold
                                                : FontWeight
                                                    .normal, // ✅ Bolder text when selected
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Net Pay Section
                  Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blueGrey, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Net Pay",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "₹ 19,445.00",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "Rupees Nineteen Thousand Four Hundred Forty Five Only",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Earnings Section
                  _ExpandableTile(
                    title: "Earnings",
                    amount: "₹ 20,853.00",
                    items: [
                      {"BASIC": "₹ 8,762.00"},
                      {"HRA": "₹ 3,505.00"},
                      {"CONVEYANCE": "₹ 1,600.00"},
                      {"MEDICAL ALLOWANCE": "₹ 1,250.00"},
                      {"SPECIAL ALLOWANCE": "₹ 5,736.00"},
                    ],
                    isExpanded: controller.isEarningsExpanded,
                    toggleExpansion: controller.toggleEarnings,
                    iconColor: Colors.green,
                  ),

                  // Deductions Section
                  _ExpandableTile(
                    title: "Deductions",
                    amount: "₹ -1,408.00",
                    items: [
                      {"PF": "₹ 1,051.00"},
                      {"ESI": "₹ 157.00"},
                      {"PROF TAX": "₹ 200.00"},
                    ],
                    isExpanded: controller.isDeductionsExpanded,
                    toggleExpansion: controller.toggleDeductions,
                    iconColor: Colors.red,
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  Container(
                    width: double.infinity, // ✅ Full Width
                    margin: const EdgeInsets.all(15),
                    padding: const EdgeInsets.all(
                        12), // ✅ Padding inside the container
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50, // ✅ Light Blue Background
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: 1,
                          color: Colors.grey.shade300), // ✅ Light Grey Border
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // ✅ Align text to the left
                      children: [
                        // Employee Details Heading
                        Text(
                          "Employee Details",
                          style: TextStyle(
                            fontSize: 14, // ✅ Proper Font Size
                            color:
                                Colors.blueGrey.shade500, // ✅ Subtle Text Color
                            fontWeight: FontWeight.w600, // ✅ Slightly bold
                          ),
                        ),
                        const SizedBox(height: 8), // ✅ Space after heading

                        // ✅ Employee Details Map (Key: Label, Value: Actual Data)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                              controller.employeeDetails.entries.map((entry) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 20), // ✅ Small space between fields
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    entry
                                        .key, // ✅ Label (e.g., "Name:", "Employee Number:")
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blueGrey
                                          .shade700, // ✅ Darker Grey for Labels
                                    ),
                                  ),
                                  Text(
                                    entry
                                        .value, // ✅ Actual Value (e.g., "Obula Kiran Kumar", "Xss-074")
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors
                                          .black, // ✅ Normal Black for Values
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  )

                  // ✅ Store Employee Details in a Map
                ],
              ),
            ),
          ),
          // Floating Button Positioned at the Top
          Positioned(
            bottom: 50, // Distance from bottom
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  generatePayslipPDF();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700, // Button Color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded Button
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                icon: const Icon(Icons.download, color: Colors.white, size: 18),
                label: const Text(
                  "Download Payslip",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Expandable Widget Using GetX
class _ExpandableTile extends StatelessWidget {
  final String title;
  final String amount;
  final List<Map<String, String>> items;
  final Color iconColor;
  final RxBool isExpanded;
  final VoidCallback toggleExpansion;

  const _ExpandableTile({
    required this.title,
    required this.amount,
    required this.items,
    required this.isExpanded,
    required this.toggleExpansion,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blueGrey, width: 1),
          ),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(amount,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 8),
                    Icon(
                      isExpanded.value
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: iconColor,
                    ),
                  ],
                ),
                onTap: toggleExpansion, // Toggle on tap
              ),
              if (isExpanded.value)
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                  child: Column(
                    children: items.map((item) {
                      String key = item.keys.first;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(key,
                                style: const TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600)),
                            Text(item[key]!,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
            ],
          ),
        ));
  }
}
