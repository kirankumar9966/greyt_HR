import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:greyt_hr/app/modules/Regularization/views/attendance_regularisation_view.dart';
import 'package:greyt_hr/app/modules/ViewApplyRegularisations/views/view_apply_regularisation_view.dart';
import 'package:greyt_hr/app/modules/ViewPendingRegularisations/views/view_pending_regularisations_view.dart';
import 'package:greyt_hr/app/modules/reviewClosedRegularisation/views/review_closed_regularisation_view.dart';
import 'package:greyt_hr/app/modules/reviewPendingRegularisation/views/review_pending_regularisation_view.dart';
import 'package:greyt_hr/app/modules/viewHistoryRegularisations/models/RegularisationHsitory.Dart.dart';
import 'package:greyt_hr/app/modules/viewHistoryRegularisations/views/view_history_regularisations_view.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
class ReviewPendingRegularisationController extends ChangeNotifier {
  // Sample loading state
  bool _isLoading = false;

  // Example pending request data
  List<String> _pendingRequests = [];
  final String apiUrl = 'http://192.168.1.38:8000/api/showPendingRegularisationRequests';

  bool get isLoading => _isLoading;
  List<String> get pendingRequests => _pendingRequests;

  // Simulated data fetch
  Future<void> fetchPendingRequests() async {
    _isLoading = true;
    notifyListeners();

    // Simulate delay

    _isLoading = false;
    notifyListeners();
  }

  Future<List<dynamic>> fetchPendingRegularisations(String token) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      print('Decoded JSON: $decoded');

      // Now access the actual list inside the nested map
      final nested = decoded['data'];

      if (nested is Map && nested['regularisations'] is List) {
        return nested['regularisations'] as List<dynamic>;
      } else {
        throw Exception(
          'Expected a list in "data[\'pending\']", got: ${nested['pending'].runtimeType}',
        );
      }
    } else {
      throw Exception('Failed to fetch regularisation data. Status: ${response.statusCode}');
    }
  }

  Future<void> reject(String id, String remarks) async {
    print('Reject');
    print(id);
    print('Rejected with remarks');
    print(remarks);
    String url = 'http://192.168.1.38:8000/api/rejectRegRequest';

    // Token
    String token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjE2OC4xLjM4OjgwMDAvYXBpL2xvZ2luIiwiaWF0IjoxNzUwMDY1MDU1LCJleHAiOjE3NTAwNzIyNTUsIm5iZiI6MTc1MDA2NTA1NSwianRpIjoiVnlLUEg1UFFDOHlTUXExZSIsInN1YiI6IlhTUy0wMzA3IiwicHJ2IjoiMzRjNDhmOTlmOTNhZWI3Nzc4YjkyZGEyNWZkNTYyYTI2ODVjYjYyNiJ9.63s9DAf6KXVrdYowrxRg295ZwIOBPbIRBtK2w1NXOEI';

    // Request body
    Map<String, String> requestBody = {
      'id': id,
      'approver_remarks': remarks,
    };

    // Headers
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      // Make the POST request
      http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(requestBody),
      );

      // Check the response status code
      if (response.statusCode == 200) {
        print('Request rejected successfully');
        print(response.body);
      } else {
        print('Failed to reject request');
        print(response.body);
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
  Future<void> approve(String id, String remarks) async {
    print('Approve');
    print(id);
    print('Approved with remarks');
    print(remarks);
    String url = 'http://192.168.1.38:8000/api/approveRegRequest';

    // Token
    String token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjE2OC4xLjM4OjgwMDAvYXBpL2xvZ2luIiwiaWF0IjoxNzUwMDU0NDQ2LCJleHAiOjE3NTAwNjE2NDYsIm5iZiI6MTc1MDA1NDQ0NiwianRpIjoiMUl4ZkNNRkJucGFsU1dyRSIsInN1YiI6IlhTUy0wMzA3IiwicHJ2IjoiMzRjNDhmOTlmOTNhZWI3Nzc4YjkyZGEyNWZkNTYyYTI2ODVjYjYyNiJ9.UZI4tbzx4ZcHTkp-VdnweZEpEpMcGlrVvPKyaQd6Duw';

    // Request body
    Map<String, String> requestBody = {
      'id': id,
      'approver_remarks': remarks,
    };

    // Headers
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      // Make the POST request
      http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(requestBody),
      );

      // Check the response status code
      if (response.statusCode == 200) {
        print('Request approved successfully');
        print(response.body);
      } else {
        print('Failed to approvest23456 request');
        print(response.body);
      }
    } catch (e) {
      print('Error occurred: $e');
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
        if (targetPage == 'Active') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ReviewPendingRegularisationsView()),
          );
        } else if (targetPage == 'Closed') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ReviewClosedRegularisationsView()),
          );
          // Already on this page
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

