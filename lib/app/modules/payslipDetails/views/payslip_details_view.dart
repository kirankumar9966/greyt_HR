import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/payslip_details_controller.dart';

class PayslipDetailsView extends GetView<PayslipDetailsController> {
  const PayslipDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PayslipDetailsController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payslip Details'),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[50],
          child: Column(
            children: [
              const SizedBox(height: 10),
        
              // Year Dropdown & Horizontal Scrollable Month Selector
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    // Year Dropdown
                    Obx(() => DropdownButton<String>(
                      value: controller.selectedYear.value,
                      items: controller.years.map((String year) {
                        return DropdownMenuItem<String>(
                          value: year,
                          child: Text(year, style: const TextStyle(fontSize: 14)),
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
                            itemCount: controller.months.length, // ✅ Now this is reactive
                            itemBuilder: (context, index) {
                              String month = controller.months[index]; // ✅ Reactive list access
                              bool isSelected = month == controller.selectedMonth.value; // ✅ This now correctly checks selection
        
                              return GestureDetector(
                                onTap: () => controller.updateMonth(month), // ✅ Update selected month
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200), // ✅ Smooth transition effect
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  margin: const EdgeInsets.symmetric(horizontal: 4),
                                  decoration: BoxDecoration(
                                    color: isSelected ? Colors.pink.shade700 : Colors.white, // ✅ Highlight if selected
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: isSelected ? Colors.pink.shade700 : Colors.blueGrey, // ✅ Change border color
                                      width: isSelected ? 2 : 1, // ✅ Slightly thicker border when selected
                                    ),
                                  ),
                                  child: Text(
                                    month,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: isSelected ? Colors.white : Colors.black, // ✅ Text color changes
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, // ✅ Bolder text when selected
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
        
        
              SizedBox(height: 20,),

          Container(
            width: double.infinity, // ✅ Full Width
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(12), // ✅ Padding inside the container
            decoration: BoxDecoration(
              color: Colors.blue.shade50, // ✅ Light Blue Background
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1, color: Colors.grey.shade300), // ✅ Light Grey Border
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // ✅ Align text to the left
              children: [
                // Employee Details Heading
                Text(
                  "Employee Details",
                  style: TextStyle(
                    fontSize: 14, // ✅ Proper Font Size
                    color: Colors.blueGrey.shade500, // ✅ Subtle Text Color
                    fontWeight: FontWeight.w600, // ✅ Slightly bold
                  ),
                ),
                const SizedBox(height: 8), // ✅ Space after heading

                // ✅ Employee Details Map (Key: Label, Value: Actual Data)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: controller.employeeDetails.entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5), // ✅ Small space between fields
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.key, // ✅ Label (e.g., "Name:", "Employee Number:")
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.blueGrey.shade700, // ✅ Darker Grey for Labels
                            ),
                          ),
                          Text(
                            entry.value, // ✅ Actual Value (e.g., "Obula Kiran Kumar", "Xss-074")
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black, // ✅ Normal Black for Values
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
                Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(width: 8),
                Icon(
                  isExpanded.value ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: iconColor,
                ),
              ],
            ),
            onTap: toggleExpansion, // Toggle on tap
          ),
          if (isExpanded.value)
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
              child: Column(
                children: items.map((item) {
                  String key = item.keys.first;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(key, style: const TextStyle(color: Colors.blueGrey,fontSize:12,fontWeight: FontWeight.w600)),
                        Text(item[key]!, style: const TextStyle(color: Colors.black,fontSize:12,fontWeight: FontWeight.w500)),
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
