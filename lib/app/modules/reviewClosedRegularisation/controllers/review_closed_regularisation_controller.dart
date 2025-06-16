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
class ReviewClosedRegularisationController extends ChangeNotifier {
  // Sample loading state
  bool _isLoading = false;
  final String apiUrl = 'http://192.168.1.38:8000/api/showClosedRegularisationRequests';
  String token='eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjE2OC4xLjM4OjgwMDAvYXBpL2xvZ2luIiwiaWF0IjoxNzUwMDY1MDU1LCJleHAiOjE3NTAwNzIyNTUsIm5iZiI6MTc1MDA2NTA1NSwianRpIjoiVnlLUEg1UFFDOHlTUXExZSIsInN1YiI6IlhTUy0wMzA3IiwicHJ2IjoiMzRjNDhmOTlmOTNhZWI3Nzc4YjkyZGEyNWZkNTYyYTI2ODVjYjYyNiJ9.63s9DAf6KXVrdYowrxRg295ZwIOBPbIRBtK2w1NXOEI';
  // Example pending request data
  List<String> _pendingRequests = [];

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


  Future<List<dynamic>> fetchClosedRegularisations(String token) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        print('API Response: $decoded');

        // ✅ Check if it's a Map and not a List
        if (decoded['data']['regularisations'] is Map<String, dynamic>) {

          return [decoded['data']['regularisations']]; // Wrap in a List
        }

        if (decoded['data']['regularisations'] is List) {

          return decoded['data']['regularisations'];
        }

        throw Exception('Expected a list or map in "data", got: ${decoded['data'].runtimeType}');
      } else {
        print('API Error: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to fetch closed regularisation data');
      }
    } catch (e) {
      print('Exception: $e');
      rethrow;
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

