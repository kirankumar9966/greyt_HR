import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:greyt_hr/app/modules/RegularisationHistoryDetailsPage/views/regularisation_history_details_page_view.dart';
import 'package:greyt_hr/app/modules/viewHistoryRegularisations/controllers/view_history_regularisations_controller.dart';
import 'package:greyt_hr/app/modules/viewHistoryRegularisations/models/RegularisationHsitory.Dart.dart';


class ViewRegularisationHistory extends StatefulWidget {
  @override
  _ViewRegularisationHistoryState createState() => _ViewRegularisationHistoryState();
}

class _ViewRegularisationHistoryState extends State<ViewRegularisationHistory> {
  late Future<List<dynamic>> _historyFuture;
  late DateTime _historyDate;
  final viewHistoryRegularisationsController = Get.put(ViewHistoryRegularisationsController());
  final ViewHistoryRegularisationsController controller = ViewHistoryRegularisationsController();

  @override
  void initState() {
    super.initState();
    print('Working or not');
    _historyFuture  = viewHistoryRegularisationsController.fetchRegularisationHistory();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Regularisation History")),
        body: Column(
          children: [
            // Tabs Row
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  controller.buildTabButton(context, 'Apply', false, 'apply'),
                  controller.buildTabButton(context, 'Pending', false, 'pending'),
                  controller.buildTabButton(context, 'History', true, 'history'),
                ],
              ),
            ),

            // Body Content (History List)
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: _historyFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return  Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Image (Make sure it's added in pubspec.yaml)
                            Image.asset(
                              'assets/images/Nothing to show.png',
                              height: 150,
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Nothing to show!',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'History requests will appear here.',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  final historyList = snapshot.data!;

                  return ListView.builder(
                    itemCount: historyList.length,
                    itemBuilder: (context, index) {
                      final history = historyList[index];
                      final status = history.statusLabel.toLowerCase();

                      final isRejected = status == 'rejected';
                      final bgColor = isRejected ? Colors.red.shade50 : Colors.grey.shade200;
                      final borderColor = isRejected ? Colors.red : Colors.grey;
                      final textColor = isRejected ? Colors.red : Colors.black87;

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: Colors.grey.shade300),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Employee Name & Status
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "${viewHistoryRegularisationsController.capitalize(history.ManagerFirstName)} ${viewHistoryRegularisationsController.capitalize(history.ManagerLastName)}",
                                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: bgColor,
                                        border: Border.all(color: borderColor),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        history.statusLabel,
                                        style: TextStyle(
                                          color: textColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                const Text('Regularized By', style: TextStyle(color: Colors.grey)),
                                const SizedBox(height: 12),

                                // Regularisation Entries
                                ...history.regularisationEntries.map<Widget>((entry) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        viewHistoryRegularisationsController.formatDateWithSuffix(entry.date),
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                      ),
                                      const Text("Applied Date(s)", style: TextStyle(color: Colors.grey)),
                                      const SizedBox(height: 12),
                                    ],
                                  );
                                }).toList(),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          viewHistoryRegularisationsController.formatDateWithSuffix(history.created_at),
                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                        ),
                                        const Text("Regularized on", style: TextStyle(color: Colors.grey)),
                                      ],
                                    ),
                                    Text(
                                      "${history.entriesCount}",
                                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                                    ),
                                  ],
                                ),

                                Align(
                                  alignment: Alignment.centerRight,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => RegularisationDetailsPageView(id: history.id, token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjE2OC4xLjM4OjgwMDAvYXBpL2xvZ2luIiwiaWF0IjoxNzUwMDU0NDQ2LCJleHAiOjE3NTAwNjE2NDYsIm5iZiI6MTc1MDA1NDQ0NiwianRpIjoiMUl4ZkNNRkJucGFsU1dyRSIsInN1YiI6IlhTUy0wMzA3IiwicHJ2IjoiMzRjNDhmOTlmOTNhZWI3Nzc4YjkyZGEyNWZkNTYyYTI2ODVjYjYyNiJ9.UZI4tbzx4ZcHTkp-VdnweZEpEpMcGlrVvPKyaQd6Duw")),
                                      );
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(color: Colors.blue.shade300),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                    ),
                                    child: const Text("View More", style: TextStyle(color: Colors.blue)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        )

    );
  }
}
