import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greyt_hr/app/modules/RegularisationHistoryDetailsPage/controllers/regularisation_history_details_page_controller.dart';
import 'package:intl/intl.dart';

import '../controllers/review_closed_regularisation_details_controller.dart';

class ReviewClosedRegularisationDetailsView extends StatefulWidget {
  final int id;
  final String token;

  const ReviewClosedRegularisationDetailsView({
    super.key,
    required this.id,
    required this.token,
  });

  @override
  State<ReviewClosedRegularisationDetailsView> createState() => _ReviewClosedRegularisationDetailsViewState();
}

class _ReviewClosedRegularisationDetailsViewState extends State<ReviewClosedRegularisationDetailsView> {
  late ReviewClosedRegularisationDetailsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ReviewClosedRegularisationDetailsController());
    controller.fetchRegularisationData(widget.id, widget.token);
    controller.fetchEmployeeName();
  }

  String capitalize(String s) => s.isNotEmpty
      ? '${s[0].toUpperCase()}${s.substring(1).toLowerCase()}'
      : '';
  String _monthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  String _weekDayName(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("View Details"),
        actions: [
          IconButton(
            icon: const Icon(Icons.home_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: Obx(() {
        final value = controller.data;
        // final rawStart = controller.data['shift_start_time'];
        // final rawEnd = controller.data['shift_end_time'];
        print('kalyani');
        print(value);
        final EmployeeName= controller.employeeFullName;
        final managerFirstName = capitalize(value['manager_first_name']);
        final managerLastName = capitalize(value['manager_last_name']);
        final SubordinateFirstName= capitalize(value['employee']['first_name']);
        final SubordinateLastName= capitalize(value['employee']['last_name']);
        final SubordinateName= '$SubordinateFirstName $SubordinateLastName';
        final ManagerName = '$managerFirstName $managerLastName';
        final ShiftStartTime=controller.ShiftStart;
        final ShiftEndTime=controller.ShiftEnd;
        final isRejected = value['status'] == 3;
        final bgColor = isRejected ? Colors.red.shade50 : Colors.grey.shade200;
        final borderColor = isRejected ? Colors.red : Colors.grey;
        final textColor = isRejected ? Colors.red : Colors.black87;
        print('kalyani and bhavana');
        print(value['entries_count']);
        final displayName = (value['status'] == 5 || value['status'] == 2 || value['status'] == 3)
            ? ManagerName
            : (value['status'] == 4  ? EmployeeName : '');

        String formatTime(String? time) {
          if (time == null) return 'N/A';
          final parsedTime = DateFormat("HH:mm:ss").parse(time);
          return DateFormat("h:mm a").format(parsedTime);
        }

        final shiftStart = formatTime(ShiftStartTime);
        final shiftEnd = formatTime(ShiftEndTime);
        final Status = value['status'];
        final statusDateString = Status == 2
            ? value['approved_date']
            : Status == 3
            ? value['rejected_date']
            : Status == 4
            ? value['withdraw_date']
            : '';
        final submittedDateString =
        value['created_at'];
        if (value.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        final entriesRaw = value['regularisation_entries'];
        final entriesCount = value['entries_count'];
        int totalEntries = 0;
        if (entriesRaw is String) {
          final parsed = jsonDecode(entriesRaw);
          if (parsed is List) {
            totalEntries = parsed.length;
          }
        }
        List<dynamic> entries = [];
        if (entriesRaw is List) {
          entries = entriesRaw;
        } else if (entriesRaw is Map) {
          entries = entriesRaw.values.toList();
        } else {
          entries = [];
        }
        print('parr');
        print(entriesRaw);
        print(value['regularisation_entries'].runtimeType);
        print('manii');
        print(entriesRaw.length);

// Decode the JSON string into a List
        if (entriesRaw is String) {
          try {
            final decoded = jsonDecode(entriesRaw);
            if (decoded is List) {
              entries = decoded;
            }
          } catch (e) {
            debugPrint("Failed to parse entries: $e");
          }
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              /// SECTION 1 — Summary Card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${value['status'] == 5 ? 'Pending with' : 'Regularization by'}\n$displayName",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),

                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: bgColor,
                              border: Border.all(color: borderColor),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              value['status_label'],
                              style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text("Total Days", style: TextStyle(color: Colors.grey)),
                      Text(
                        "${entriesCount}".padLeft(2, '0'),
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      const Text("Remarks", style: TextStyle(color: Colors.grey)),
                      Text(value['employee_remarks'] ?? '-', style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 14),
                      Center(
                        child: OutlinedButton(
                          onPressed: () =>  _showTimelineDialog(context,Status,displayName,EmployeeName,statusDateString,submittedDateString,SubordinateName),
                          child: const Text("View Timeline"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              /// SECTION 2 — Loop Through Entries
              ...List.generate(entries?.length ?? 0, (index) {
                final entry = entries[index];
                final date = DateTime.parse(entry['date']);
                final formattedDate = "${date.day.toString().padLeft(2, '0')} ${_monthName(date.month)} ${date.year}";
                final weekDay = _weekDayName(date.weekday);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("$formattedDate\n$weekDay", style: const TextStyle(fontWeight: FontWeight.bold)),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: bgColor,
                                  border: Border.all(color: borderColor),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  value['status_label'],
                                  style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),

                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Shift: $shiftStart to $shiftEnd",
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(entry['from'], style: const TextStyle(fontWeight: FontWeight.bold)),
                                  const Text("IN", style: TextStyle(color: Colors.orange)),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(entry['to'], style: const TextStyle(fontWeight: FontWeight.bold)),
                                  const Text("OUT", style: TextStyle(color: Colors.orange)),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text("Approver’s Remark", style: TextStyle(color: Colors.grey)),
                          Text(value['approver_remarks'] ?? '-', style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 8),
                          const Text("Reason", style: TextStyle(color: Colors.grey)),
                          Text(entry['reason'] ?? '-', style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      }),
    );
  }
}
void _showTimelineDialog(BuildContext context, int status,String? displayName,String? EmployeeName,String? statusDateString,String? submittedDateString,String? SubordinateName) {
  String statusLabel = status == 2
      ? 'Approved by'
      : status == 3
      ? 'Rejected by'
      : status == 4
      ? 'Withdrawn by'
      : status == 5
      ? 'Pending With'
      : '';
  String? Name= displayName;
  String? SubordinateName1=SubordinateName;
  // final formattedStatusDate = statusDate != null
  //     ? DateFormat('d MMM, y | hh:mm a').format(statusDate!)
  //     : '';
  DateTime? statusDate = statusDateString != null ? DateTime.parse(statusDateString) : null;

// Format DateTime to String
  final String formattedStatusDate = statusDate != null
      ? DateFormat('d MMM, y | hh:mm a').format(statusDate)
      : '';

  DateTime? submittedDate = submittedDateString != null ? DateTime.parse(submittedDateString) : null;

// Format DateTime to String
  final String formattedsubmittedDate = submittedDate != null
      ? DateFormat('d MMM, y | hh:mm a').format(submittedDate)
      : '';

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(20),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Application Timeline',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Center(
              child: Image.asset(
                'assets/images/clock.png',
                height: 50,
                width: 50,
              ),
            ),
            const SizedBox(height: 20),
            _buildTimelineRow(
              dotColor: Colors.blue,
              label: '$statusLabel $Name',
              dateTime: formattedStatusDate,
            ),
            const SizedBox(height: 10),
            _buildTimelineRow(
              dotColor: Colors.grey,
              label: 'Submitted by $SubordinateName1',
              dateTime: formattedsubmittedDate,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}

Widget _buildTimelineRow({
  required Color dotColor,
  required String label,
  required String dateTime,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Column(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
            ),
          ),
          Container(
            width: 2,
            height: 25,
            color: Colors.grey.shade300,
          ),
        ],
      ),
      const SizedBox(width: 10),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 2),
          Text(dateTime, style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    ],
  );
}

