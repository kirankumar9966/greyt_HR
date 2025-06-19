import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HelpdeskController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  var pendingRequests = <Map<String, String>>[].obs;
  var historyRequests = <Map<String, String>>[].obs;

  var selectedCategory = ''.obs;
  var selectedPriority = ''.obs;
  var fileName = ''.obs;
  final subjectController = TextEditingController();
  final descriptionController = TextEditingController();

  final categories = ['IT Support', 'HR', 'Payroll', 'General'].obs;
  final priorities = ['High', 'Medium', 'Low'].obs;


  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    loadMockData();
  }

  void loadMockData() {
    pendingRequests.assignAll([
      {
        'category': 'Employee Information',
        'subject': 'Education',
        'date': '02 May 2025',
        'description': 'Requesting for Education Certificate update',
        'priority': 'High',
        'status': 'Pending',
        'assigned': 'Raja',
      },
    ]);

    historyRequests.assignAll([
      {
        'category': 'Employee Details',
        'subject': 'Address Change',
        'date': '25 Apr 2025',
        'description': 'Change address to Bangalore',
        'priority': 'Medium',
        'status': 'Approved',
        'assigned': 'Kiran',
      },
    ]);
  }

  void pickFile() {
    fileName.value = 'dummy_file.pdf';
  }

  void clearForm() {
    selectedCategory.value = '';
    selectedPriority.value = '';
    fileName.value = '';
    subjectController.clear();
    descriptionController.clear();
  }

  void submit() {
    if (selectedCategory.value.isNotEmpty &&
        selectedPriority.value.isNotEmpty &&
        subjectController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty) {
      Get.snackbar('Submitted', 'Your request has been submitted successfully!',
          snackPosition: SnackPosition.BOTTOM);
      clearForm();
    } else {
      Get.snackbar('Error', 'Please fill all required fields',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red.shade100);
    }
  }

  void openDetails(BuildContext context, Map<String, String> data) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text("Pending with \${data['assigned']}"),
              trailing: Chip(
                label: Text(data['status'] ?? ''),
                backgroundColor: Colors.orange.shade100,
              ),
            ),
            Divider(),
            _infoRow("Applied On", data['date']),
            _infoRow("Subject", data['subject']),
            _infoRow("Priority", data['priority']),
            _infoRow("Category", data['category']),
            SizedBox(height: 12),
            Text("Description", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text(data['description'] ?? ''),
            SizedBox(height: 16),
            Center(
              child: OutlinedButton(
                onPressed: () {
                  openTimeline(context, data);
                },
                child: Text("View Timeline"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openTimeline(BuildContext context, Map<String, String> data) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.access_time),
              title: Text("Application Timeline"),
            ),
            Divider(),
            Row(
              children: [
                Icon(Icons.brightness_1, color: Colors.blue, size: 12),
                SizedBox(width: 8),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Pending with \${data['assigned']}"),
                        Text("Note here", style: TextStyle(color: Colors.grey)),
                        Text("Show More", style: TextStyle(color: Colors.blue)),
                      ],
                    )
                ),
              ],
            ),
            SizedBox(height: 20),
            Text("Submitted by Obula Kiran Kumar", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("\${data['date']} • 11:57 AM", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 120, child: Text(title)),
          Expanded(child: Text(value ?? '')),
        ],
      ),
    );
  }

  Widget buildApplyForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Category"),
          Obx(() => DropdownButtonFormField<String>(
            decoration: InputDecoration(border: OutlineInputBorder()),
            hint: Text("Select Category"),
            value: selectedCategory.value.isEmpty ? null : selectedCategory.value,
            items: categories
                .map((cat) => DropdownMenuItem(
              value: cat,
              child: Text(cat),
            ))
                .toList(),
            onChanged: (val) => selectedCategory.value = val ?? '',
          )),
          SizedBox(height: 16),
          TextFormField(
            controller: subjectController,
            decoration: InputDecoration(
              labelText: "Enter Subject",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: descriptionController,
            maxLines: 4,
            decoration: InputDecoration(
              labelText: "Write Here",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          Text("Priority"),
          Obx(() => DropdownButtonFormField<String>(
            decoration: InputDecoration(border: OutlineInputBorder()),
            hint: Text("Select Priority"),
            value: selectedPriority.value.isEmpty ? null : selectedPriority.value,
            items: priorities
                .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                .toList(),
            onChanged: (val) => selectedPriority.value = val ?? '',
          )),
          SizedBox(height: 16),
          Text("Upload File"),
          Obx(() => Text(fileName.value.isEmpty ? 'No file selected' : fileName.value)),
          SizedBox(height: 8),
          OutlinedButton(
            onPressed: pickFile,
            child: Text("Pick File"),
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                onPressed: clearForm,
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: submit,
                child: Text("Submit"),
              )
            ],
          )
        ],
      ),
    );
  }
}
