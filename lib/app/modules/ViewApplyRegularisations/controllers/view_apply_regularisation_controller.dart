import 'package:flutter/material.dart';
import 'package:greyt_hr/app/modules/ViewApplyRegularisations/views/view_apply_regularisation_view.dart';
import 'package:greyt_hr/app/modules/ViewPendingRegularisations/views/view_pending_regularisations_view.dart';
import 'package:greyt_hr/app/modules/viewHistoryRegularisations/views/view_history_regularisations_view.dart';

class ViewApplyRegularisationController extends ChangeNotifier {
  // Sample loading state
  bool _isLoading = false;

  // Example pending request data
  List<String> _pendingRequests = [];

  List<DateTime> _holidayDates = [];
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

