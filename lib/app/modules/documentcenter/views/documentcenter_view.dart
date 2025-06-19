import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/documentcenter_controller.dart';


class DocumentcenterView extends GetView<DocumentcenterController> {
  const DocumentcenterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Document Center')),
      body: Obx(() {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: controller.documentData.keys.map((title) {
            return _buildTile(
              context,
              title,
              controller.icons[title]!,
              controller.iconColors[title]!,
              controller.documentData[title]!,
            );
          }).toList(),
        );
      }),
    );
  }

  Widget _buildTile(
      BuildContext context,
      String title,
      IconData icon,
      Color color,
      List<String> subItems,
      ) {
    final isOpen = controller.isOpen[title] ?? false;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          ListTile(

            leading: CircleAvatar(
              backgroundColor: color.withAlpha((0.15 * 255).toInt()),
              child: Icon(icon, color: color),
            ),

            title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            trailing: Icon(isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
            onTap: () => controller.toggleTile(title),
          ),
          if (isOpen) const Divider(height: 1),
          if (isOpen)
            subItems.isEmpty
                ? const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Uh oh! Nothing to show.', style: TextStyle(color: Colors.grey)),
            )
                : Column(
              children: subItems.map((item) {
                return InkWell(
                  onTap: () => _openBottomSheet(context, title, item),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        const Icon(Icons.insert_drive_file, size: 20, color: Colors.grey),
                        const SizedBox(width: 10),
                        Text(item, style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  void _openBottomSheet(BuildContext context, String title, String item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.9,
        builder: (_, controller) {
          if (title == 'Forms') return _formDetailView(controller);
          if (title == 'Payslips') return _payslipDetailView(controller);
          if (title == 'Letters') return _letterDetailView(controller);
          if (title == 'Documents' && item == 'Previous Employment') return _previousEmploymentView(controller);
          return const Center(child: Text('No details available.'));
        },
      ),
    );
  }

  Widget _formDetailView(ScrollController scrollController) {
    final forms = [
      {'title': 'General HR Form', 'date': '10 Apr 2024', 'file': 'HR_Declaration_Form.pdf'},
      {'title': 'Medical Reimbursement', 'date': '22 Mar 2024', 'file': 'Medical_Claim_Form.pdf'},
    ];

    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: forms.length,
      itemBuilder: (_, index) {
        final form = forms[index];
        return _buildCard(form['title']!, form['date']!, form['file']!);
      },
    );
  }

  Widget _payslipDetailView(ScrollController scrollController) {
    final payslips = [
      {'month': 'March 2024', 'date': '03 Apr 2024', 'file': 'Payslip_March2024.pdf'},
      {'month': 'February 2024', 'date': '04 Mar 2024', 'file': 'Payslip_February2024.pdf'},
      {'month': 'January 2024', 'date': '05 Feb 2024', 'file': 'Payslip_January2024.pdf'},
    ];

    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: payslips.length,
      itemBuilder: (_, index) {
        final p = payslips[index];
        return _buildCard(p['month']!, p['date']!, p['file']!);
      },
    );
  }

  Widget _letterDetailView(ScrollController scrollController) {
    final letters = [
      {'title': 'Appointment Letter', 'date': 'Issued on 15 Mar 2024'},
      {'title': 'Confirmation Letter', 'date': 'Issued on 15 Sep 2024'},
    ];

    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: letters.length,
      itemBuilder: (_, index) {
        final letter = letters[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: ListTile(
            title: Text(letter['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(letter['date']!),
            trailing: ElevatedButton.icon(
              onPressed: () {
                Get.snackbar("Downloading", letter['title']!, snackPosition: SnackPosition.BOTTOM);
              },
              icon: const Icon(Icons.download, size: 18),
              label: const Text('Download'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade600,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                textStyle: const TextStyle(fontSize: 14),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _previousEmploymentView(ScrollController scrollController) {
    return ListView(
      controller: scrollController,
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("SVS Group of Institutes", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                const Text("Last updated on 16 Jun 2023", style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 16),
                const Text("2.pdf", style: TextStyle(fontSize: 16, color: Colors.black87)),
                const SizedBox(height: 4),
                const Text("Service_Letter_Padmavathi.pdf", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.indigo,
                      side: const BorderSide(color: Colors.indigo),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    ),
                    onPressed: () {
                      Get.snackbar("Downloading", "Previous Employment File");
                    },
                    child: const Text("Download"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCard(String title, String date, String fileName) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text('Last updated on $date', style: const TextStyle(color: Colors.grey, fontSize: 13)),
            const SizedBox(height: 12),
            Text(fileName, style: const TextStyle(color: Colors.indigo, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.indigo,
                  side: const BorderSide(color: Colors.indigo),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: () {
                  Get.snackbar("Downloading", fileName, snackPosition: SnackPosition.BOTTOM);
                },
                child: const Text("Download"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
