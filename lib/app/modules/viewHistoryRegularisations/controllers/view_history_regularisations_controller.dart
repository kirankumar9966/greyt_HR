import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:greyt_hr/app/modules/ViewApplyRegularisations/views/view_apply_regularisation_view.dart';
import 'package:greyt_hr/app/modules/ViewPendingRegularisations/views/view_pending_regularisations_view.dart';
import 'package:greyt_hr/app/modules/viewHistoryRegularisations/models/RegularisationHsitory.Dart.dart';
import 'package:greyt_hr/app/modules/viewHistoryRegularisations/views/view_history_regularisations_view.dart';
import 'package:greyt_hr/app/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ViewHistoryRegularisationsController extends ChangeNotifier {
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
    fetchRegularisationHistory();
  }
  String capitalize(String name) {
    if (name.isEmpty) return '';
    return name[0].toUpperCase() + name.substring(1).toLowerCase();
  }

  Future<List<dynamic>> fetchRegularisationHistory() async {
    try {
      final token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjE2OC4xLjM4OjgwMDAvYXBpL2xvZ2luIiwiaWF0IjoxNzUwMDU0NDQ2LCJleHAiOjE3NTAwNjE2NDYsIm5iZiI6MTc1MDA1NDQ0NiwianRpIjoiMUl4ZkNNRkJucGFsU1dyRSIsInN1YiI6IlhTUy0wMzA3IiwicHJ2IjoiMzRjNDhmOTlmOTNhZWI3Nzc4YjkyZGEyNWZkNTYyYTI2ODVjYjYyNiJ9.UZI4tbzx4ZcHTkp-VdnweZEpEpMcGlrVvPKyaQd6Duw';

      print('Testing Token: ${token}');

      final response = await http.post(
        Uri.parse("http://192.168.1.38:8000/api/regularisation-history"),
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
       print('hii mannii ${data.map((item) => RegularisationHistory.fromJson(item)).toList()}');
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

