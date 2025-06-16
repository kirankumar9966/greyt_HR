import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:greyt_hr/app/modules/RegularisationHistoryDetailsPage/views/regularisation_history_details_page_view.dart';
import 'package:greyt_hr/app/modules/ReviewClosedRegularisationDetails/views/review_closed_regularisation_details_view.dart';
import 'package:greyt_hr/app/modules/reviewClosedRegularisation/controllers/review_closed_regularisation_controller.dart';

class ReviewClosedRegularisationsView extends StatelessWidget {
  const ReviewClosedRegularisationsView({super.key});

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
    return '${day}${suffix} ${_monthName(date.month)} ${date.year}';
  }

  String _formatDate(String dateString) {
    if (dateString.isEmpty) return '';
    final date = DateTime.parse(dateString);
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
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '$day$suffix ${months[date.month - 1]} ${date.year}';
  }

  String _monthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }


  List<dynamic> decodeRegularisationEntries(dynamic input) {
    try {
      if (input is List) return input;

      if (input is String) {
        dynamic firstDecode = jsonDecode(input);

        // Handle if the first decode still gives a string (double-encoded)
        if (firstDecode is String) {
          return List<dynamic>.from(jsonDecode(firstDecode));
        }

        return List<dynamic>.from(firstDecode);
      }
    } catch (e) {
      print('❌ Failed to decode: $e');
    }

    return [];
  }
  @override
  Widget build(BuildContext context) {
    final ReviewClosedRegularisationController controller=ReviewClosedRegularisationController();

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
      body:  FutureBuilder<List<dynamic>>(
    future: controller.fetchClosedRegularisations('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjE2OC4xLjM4OjgwMDAvYXBpL2xvZ2luIiwiaWF0IjoxNzUwMDY1MDU1LCJleHAiOjE3NTAwNzIyNTUsIm5iZiI6MTc1MDA2NTA1NSwianRpIjoiVnlLUEg1UFFDOHlTUXExZSIsInN1YiI6IlhTUy0wMzA3IiwicHJ2IjoiMzRjNDhmOTlmOTNhZWI3Nzc4YjkyZGEyNWZkNTYyYTI2ODVjYjYyNiJ9.63s9DAf6KXVrdYowrxRg295ZwIOBPbIRBtK2w1NXOEI'),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return const Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
    return Center(child: Text('Error: ${snapshot.error}'));
    }

    final pendingList = snapshot.data ?? [];

    if (pendingList.isEmpty) {
      return   Column( children:[
      Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
      controller.buildTabButton(context, 'Active', false, 'Active'),
      controller.buildTabButton(context, 'Closed', true, 'Closed'),
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
                'Closed regularisation requests will appear here.',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
        ],
        );

    }
    return
      Column(
        children: [
          // Your top tab container
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                controller.buildTabButton(context, 'Active', false, 'Active'),
                controller.buildTabButton(context, 'Closed', true, 'Closed'),
              ],
            ),
          ),

          // The list view
          Expanded(
            child: ListView.builder(
              itemCount: pendingList.length,
              itemBuilder: (context, index) {
                final item = pendingList[index];
                final decodedEntries = decodeRegularisationEntries(item['regularisation_entries']);
                final status = item['status_label'].toLowerCase();

                final isRejected = status == 'rejected';
                final bgColor = isRejected ? Colors.red.shade50 : Colors.grey.shade200;
                final borderColor = isRejected ? Colors.red : Colors.grey;
                final textColor = isRejected ? Colors.red : Colors.black87;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                    color: Colors.purple.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:[
                              Flexible(
                                child:
                                Text(
                                  "${capitalize(item['employee']['first_name']) ?? ''} ${capitalize(item['employee']['last_name']) ?? ''} (${item['employee']['emp_id']})",
                                  style: const TextStyle(color: Colors.black),
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
                                  item['status_label'],
                                  style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Column(
                            children: decodedEntries.map<Widget>((entry) {
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
                           const SizedBox(height: 10),
                          const Text("Applied on", style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _formatDate(item['created_at']),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "${decodedEntries.length}",
                                style: const TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ReviewClosedRegularisationDetailsView(
                                        id: item['id'],
                                        token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjE2OC4xLjM4OjgwMDAvYXBpL2xvZ2luIiwiaWF0IjoxNzUwMDY1MDU1LCJleHAiOjE3NTAwNzIyNTUsIm5iZiI6MTc1MDA2NTA1NSwianRpIjoiVnlLUEg1UFFDOHlTUXExZSIsInN1YiI6IlhTUy0wMzA3IiwicHJ2IjoiMzRjNDhmOTlmOTNhZWI3Nzc4YjkyZGEyNWZkNTYyYTI2ODVjYjYyNiJ9.63s9DAf6KXVrdYowrxRg295ZwIOBPbIRBtK2w1NXOEI", // pass real token or fetch dynamically
                                      ),
                                    ),
                                  );
                                },
                                child: const Text("View More"),
                              ),
                            ],
                          )
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
