import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:greyt_hr/app/modules/Regularization/views/attendance_regularisation_view.dart';
import 'package:greyt_hr/app/modules/ViewApplyRegularisations/views/view_apply_regularisation_view.dart';
import 'package:greyt_hr/app/modules/ViewPendingRegularisations/views/view_pending_regularisations_view.dart';
import 'package:greyt_hr/app/modules/viewHistoryRegularisations/models/RegularisationHsitory.Dart.dart';
import 'package:greyt_hr/app/modules/viewHistoryRegularisations/views/view_history_regularisations_view.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
class ViewPendingRegularisationsController extends ChangeNotifier {
  // Sample loading state
  bool _isLoading = false;

  // Example pending request data
  List<String> _pendingRequests = [];

  bool get isLoading => _isLoading;
  List<String> get pendingRequests => _pendingRequests;

  // Simulated data fetch
  Future<void> fetchPendingRequests() async {
    _isLoading = true;
    notifyListeners();

    // Simulate delay
    await Future.delayed(Duration(seconds: 2));

    // Update with sample data or empty
    _pendingRequests = []; // or ['Req 1', 'Req 2']
    _isLoading = false;
    notifyListeners();
  }
  Future<List<dynamic>> fetchPendingRegularisation() async {
    try {
      final token =  'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjE2OC4xLjM4OjgwMDAvYXBpL2xvZ2luIiwiaWF0IjoxNzUwMDcyNDMxLCJleHAiOjE3NTAwNzk2MzEsIm5iZiI6MTc1MDA3MjQzMSwianRpIjoicThuMGRUSXZqS1JlWXNhRCIsInN1YiI6IlhTUy0wMzA3IiwicHJ2IjoiMzRjNDhmOTlmOTNhZWI3Nzc4YjkyZGEyNWZkNTYyYTI2ODVjYjYyNiJ9.UxPgjmT_-al3yuGlEonMwkH913QKEdTZeN11hKWOPDc';

      print('Testing Token: ${token}');

      final response = await http.post(
        Uri.parse("http://192.168.1.38:8000/api/regularisation-pending"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );


      print('📥 Received response with status code: ${response.statusCode}');
      print('🧾 Response body: ${response.body}');

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final data = body['data'] as List;
        print('parr');
        print(data);
        print('manii');
        print(data.map((item) => RegularisationHistory.fromJson(item)).toList());
        return data.map((item) => RegularisationHistory.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load regularisation history');
      }
    } catch (e) {
      print('🔥 Exception caught: $e');
      throw Exception('Error occurred: $e');
    }
  }


  String formatDateWithSuffix(String rawDate) {
    DateTime date = DateTime.parse(rawDate);
    int day = date.day;

    String suffix;
    if (day >= 11 && day <= 13) {
      suffix = 'th';
    } else {
      switch (day % 10) {
        case 1:
          suffix = 'st';
          break;
        case 2:
          suffix = 'nd';
          break;
        case 3:
          suffix = 'rd';
          break;
        default:
          suffix = 'th';
      }
    }

    String formattedDate = "${day}$suffix ${DateFormat('MMMM, y').format(date)}";
    return formattedDate;
  }
  String capitalize(String name) {
    if (name.isEmpty) return '';
    return name[0].toUpperCase() + name.substring(1).toLowerCase();
  }

  Future<void> withdrawRegularization(BuildContext context, int id) async {
    // Your withdrawal logic, e.g., API call
    print("Withdrawal function called for ID: $id");

    // API endpoint
    final url = Uri.parse("http://192.168.1.38:8000/api/withdrawRegRequest");

    // Token
    final token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjE2OC4xLjM4OjgwMDAvYXBpL2xvZ2luIiwiaWF0IjoxNzUwMDcyNDMxLCJleHAiOjE3NTAwNzk2MzEsIm5iZiI6MTc1MDA3MjQzMSwianRpIjoicThuMGRUSXZqS1JlWXNhRCIsInN1YiI6IlhTUy0wMzA3IiwicHJ2IjoiMzRjNDhmOTlmOTNhZWI3Nzc4YjkyZGEyNWZkNTYyYTI2ODVjYjYyNiJ9.UxPgjmT_-al3yuGlEonMwkH913QKEdTZeN11hKWOPDc';

    // You can use the current date as withdraw_date
    final String withdrawDate = DateTime.now().toIso8601String();

    try {
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'id': id, // Pass ID in the request body
          'withdraw_date': withdrawDate,
          'is_withdraw': 1,
          'status': 4,
        }),
      );

      if (response.statusCode == 200) {
        print("Withdraw successful: ${response.body}");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AttendanceRegularisationView(),
          ),
        );
        // Show a success message using SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Withdrawal successful')),
        );
      } else {
        print("Withdraw failed: ${response.statusCode} - ${response.body}");
        // Show an error message using SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Withdrawal failed: ${response.statusCode} - ${response.body}')),
        );
      }
    } catch (e) {
      print("Error occurred during withdrawal: $e");
      // Show an error message using SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred during withdrawal: $e')),
      );
    }
  }

  Widget buildTabButton(
      BuildContext context,
      String label,
      bool isSelected,
      String targetPage,
      ) {
    return GestureDetector(
      onTap: () {
        if (targetPage == 'apply') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ApplyRegularisationView()),
          );
        } else if (targetPage == 'pending') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ViewPendingRegularisationsView()),
          );
          // Already on this page
        } else if (targetPage == 'history') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ViewRegularisationHistory()),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.blue : Colors.grey,
              ),
            ),
          ),
          if (isSelected)
            Container(
              height: 2,
              width: 30,
              color: Colors.blueAccent,
            ),
        ],
      ),
    );
  }
}

