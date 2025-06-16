import 'dart:convert';

class RegularisationEntry {
  final String date;
  final String from;
  final String to;
  final String reason;

  RegularisationEntry({
    required this.date,
    required this.from,
    required this.to,
    required this.reason,
  });

  factory RegularisationEntry.fromJson(Map<String, dynamic> json) {
    return RegularisationEntry(
      date: json['date'] ?? '',
      from: json['from'] ?? '',
      to: json['to'] ?? '',
      reason: json['reason'] ?? '',
    );
  }
}

class RegularisationHistory {
  final int id;
  final String empId;
  final List<RegularisationEntry> regularisationEntries;
  final String? employeeRemarks;
  final String? approverRemarks;
  final String? approvedDate;
  final int status;
  final String statusLabel;
  final String? ManagerFirstName;
  final String? ManagerLastName;
  final int entriesCount;
  final String? created_at;

  RegularisationHistory({
    required this.id,
    required this.empId,
    required this.regularisationEntries,
    this.employeeRemarks,
    this.approverRemarks,
    this.approvedDate,
    required this.status,
    required this.statusLabel,
    this.ManagerFirstName,
    this.ManagerLastName,
    required this.entriesCount,
    this.created_at,
  });

  factory RegularisationHistory.fromJson(Map<String, dynamic> json) {
    List<RegularisationEntry> entries = [];

    try {
      final rawEntries = json['regularisation_entries'];

      // Handle if it's a double-encoded string
      if (rawEntries is String) {
        dynamic decoded = jsonDecode(rawEntries);
        if (decoded is String) {
          decoded = jsonDecode(decoded); // Handle double-encoded JSON
        }
        if (decoded is List) {
          entries = decoded.map((e) => RegularisationEntry.fromJson(e)).toList();
        }
      } else if (rawEntries is List) {
        entries = rawEntries.map((e) => RegularisationEntry.fromJson(e)).toList();
      }
    } catch (e) {
      print("⚠️ Error decoding regularisation_entries: $e");
    }

    return RegularisationHistory(
      id: json['id'] ?? 0, // Provide a default value if id is null
      empId: json['emp_id'] ?? '', // Provide a default value if empId is null
      regularisationEntries: entries,
      employeeRemarks: json['employee_remarks'],
      approverRemarks: json['approver_remarks'],
      approvedDate: json['approved_date'],
      status: json['status'] ?? 0, // Provide a default value if status is null
      statusLabel: json['status_label'] ?? '', // Provide a default value if statusLabel is null
      ManagerFirstName: json['manager_first_name'],
      ManagerLastName: json['manager_last_name'],
      entriesCount: json['entries_count'] ?? 0, // Provide a default value if entriesCount is null
      created_at: json['created_at'],
    );
  }
}