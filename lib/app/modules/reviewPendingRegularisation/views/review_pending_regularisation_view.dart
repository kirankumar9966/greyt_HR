import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:greyt_hr/app/modules/ReviewPendingRegularisationDetails/views/review_pending_regularisation_details_view.dart';
import 'package:greyt_hr/app/modules/reviewPendingRegularisation/controllers/review_pending_regularisation_controller.dart';

class ReviewPendingRegularisationsView extends StatelessWidget {
  const ReviewPendingRegularisationsView({super.key});

  String capitalize(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1).toLowerCase();
  }

  String formatDateWithSuffix(DateTime date) {
    final day = date.day;
    final suffix = (day >= 11 && day <= 13)
        ? 'th'
        : (day % 10 == 1)
        ? 'st'
        : (day % 10 == 2)
        ? 'nd'
        : (day % 10 == 3)
        ? 'rd'
        : 'th';
    return '$day$suffix ${_monthName(date.month)} ${date.year}';
  }

  List<dynamic> decodeRegularisationEntries(dynamic input) {
    try {
      if (input is List) return input;
      if (input is String) {
        final first = jsonDecode(input);
        if (first is String) return jsonDecode(first);
        return first;
      }
    } catch (e) {
      print('Decode error: $e');
    }
    return [];
  }

  String _monthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final ReviewPendingRegularisationController controller =
    ReviewPendingRegularisationController();

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Regularization', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.home_outlined),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: controller.fetchPendingRegularisations('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjE2OC4xLjM4OjgwMDAvYXBpL2xvZ2luIiwiaWF0IjoxNzUwMDY1MDU1LCJleHAiOjE3NTAwNzIyNTUsIm5iZiI6MTc1MDA2NTA1NSwianRpIjoiVnlLUEg1UFFDOHlTUXExZSIsInN1YiI6IlhTUy0wMzA3IiwicHJ2IjoiMzRjNDhmOTlmOTNhZWI3Nzc4YjkyZGEyNWZkNTYyYTI2ODVjYjYyNiJ9.63s9DAf6KXVrdYowrxRg295ZwIOBPbIRBtK2w1NXOEI'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final pendingList = snapshot.data ?? [];

          print('Snapshot Data: ${snapshot.data}');
          // final pendingList = snapshot.data ?? [];

          if (pendingList.isEmpty) {
            return  Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      controller.buildTabButton(context, 'Active', true, 'Active'),
                      controller.buildTabButton(context, 'Closed', false, 'Closed'),
                    ],
                  ),
                ),

                Expanded(
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
                      'Pending regularisation requests will appear here.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
               ),
              ),
            ],
            );
          }
          return Column(
            children: [
              // Tab Bar
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    controller.buildTabButton(context, 'Active', true, 'Active'),
                    controller.buildTabButton(context, 'Closed', false, 'Closed'),
                  ],
                ),
              ),

              // List of Cards
              Expanded(
                child: ListView.builder(
                  itemCount: pendingList.length,
                  itemBuilder: (context, index) {
                    final history = pendingList[index];

                    final status = (history['statusLabel'] as String?)?.toLowerCase() ?? '';
                    final isRejected = status == 'rejected';
                    final bgColor = isRejected ? Colors.red.shade50 : Colors.grey.shade200;
                    final borderColor = isRejected ? Colors.red : Colors.grey;
                    final textColor = isRejected ? Colors.red : Colors.black87;
                    List<dynamic> entries = decodeRegularisationEntries(history['regularisation_entries']);

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
                              // Manager Name & Status
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      "${capitalize(history['employee']['first_name'] ?? '')} ${capitalize(history['employee']['last_name'] ?? '')}  (${history['employee']['emp_id']})",
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                  ),

                                ],
                              ),


                              const SizedBox(height: 12),

                              // Applied Dates

                           Column(
                          children: entries.map<Widget>((entry) {
                                  return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  Text(
                                  formatDateWithSuffix(DateTime.parse(entry['date'])),
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                const Text("Applied Date(s)", style: TextStyle(color: Colors.grey)),
                                const SizedBox(height: 12),
                                ],
                                );
                                }).toList(),
                                ),

                    // Created Date & Entry Count
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      const Text("Applied on", style: TextStyle(color: Colors.grey)),
                                      Text(
                                        formatDateWithSuffix(DateTime.parse(history['created_at'])),
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${(history['regularisation_entries_count'] ?? [])}",
                                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 12),

                              // Buttons: View More | Approve | Reject
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  OutlinedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ReviewPendingRegularisationDetailsView(
                                            id: history['id'],
                                            token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjE2OC4xLjM4OjgwMDAvYXBpL2xvZ2luIiwiaWF0IjoxNzUwMDY1MDU1LCJleHAiOjE3NTAwNzIyNTUsIm5iZiI6MTc1MDA2NTA1NSwianRpIjoiVnlLUEg1UFFDOHlTUXExZSIsInN1YiI6IlhTUy0wMzA3IiwicHJ2IjoiMzRjNDhmOTlmOTNhZWI3Nzc4YjkyZGEyNWZkNTYyYTI2ODVjYjYyNiJ9.63s9DAf6KXVrdYowrxRg295ZwIOBPbIRBtK2w1NXOEI", // pass real token or fetch dynamically
                                          ),
                                        ),
                                      );
                                      // View More Logic
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(color: Colors.blue.shade300),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                    ),
                                    child: const Text("View More", style: TextStyle(color: Colors.blue)),
                                  ),
                                  const SizedBox(width: 8),
                                  ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          String remarks = ''; // Local variable to hold user input

                                          return StatefulBuilder(
                                            builder: (context, setState) {
                                              return AlertDialog(
                                                title: const Text('Confirm Approval'),
                                                content: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    const Text("Are you sure you want to approve the regularisation request?"),
                                                    const SizedBox(height: 16),
                                                    TextField(
                                                      onChanged: (value) {
                                                        remarks = value;
                                                      },
                                                      decoration: const InputDecoration(
                                                        labelText: 'Remarks',
                                                        border: OutlineInputBorder(),
                                                      ),
                                                      maxLines: 2,
                                                    ),
                                                  ],
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () => Navigator.pop(context),
                                                    child: const Text('Cancel'),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context); // Close the dialog
                                                      // TODO: Handle approval logic with `remarks`
                                                      print('Approved with remarks: $remarks');
                                                      controller.approve(history['id'].toString(), remarks);

                                                    },
                                                    child: const Text('Approve'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                    ),
                                    child: const Text("Approve"),
                                  ),

                                  const SizedBox(width: 8),
                                  ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          String remarks = '';

                                          return StatefulBuilder(
                                            builder: (context, setState) {
                                              return AlertDialog(
                                                title: const Text('Confirm Rejection'),
                                                content: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    const Text("Are you sure you want to reject the regularisation request?"),
                                                    const SizedBox(height: 16),
                                                    TextField(
                                                      onChanged: (value) {
                                                        remarks = value;
                                                      },
                                                      decoration: const InputDecoration(
                                                        labelText: 'Remarks',
                                                        border: OutlineInputBorder(),
                                                      ),
                                                      maxLines: 2,
                                                    ),
                                                  ],
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () => Navigator.pop(context),
                                                    child: const Text('Cancel'),
                                                  ),
                                                  ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: Colors.red,
                                                      foregroundColor: Colors.white,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      // TODO: Handle rejection logic with `remarks`
                                                      print('Rejected with remarks: $remarks');
                                                      controller.reject(history['id'].toString(), remarks);
                                                    },
                                                    child: const Text('Reject'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                    ),
                                    child: const Text("Reject"),
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
