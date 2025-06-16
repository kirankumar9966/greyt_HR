import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:greyt_hr/app/modules/ViewApplyRegularisations/views/view_apply_regularisation_view.dart';
import 'package:greyt_hr/app/modules/ViewPendingRegularisations/bindings/view_pending_regularisations_binding.dart';
import 'package:greyt_hr/app/modules/ViewPendingRegularisations/views/view_pending_regularisations_view.dart';
// import 'package:greyt_hr/app/modules/applyRegularisationsForEmployee/views/apply_regularisations_for_employee_view.dart';

class AttendanceRegularisationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apply Regularization'),

        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              // navigate to home
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Static Title


            // Static Info Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: SizedBox(
                height: 180, // You can adjust this value as needed
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Card Title

                      Text(
                          "Regularisation",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      Spacer(),

                      // Buttons at the bottom
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end, // aligns both buttons to the right
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Get.to(() => ViewPendingRegularisationsView());
                              // Navigate to pending view
                            },
                            child: Text("View Pending"),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.blueAccent,
                            ),
                          ),
                          SizedBox(width: 8), // small spacing between buttons
                          ElevatedButton(
                            onPressed: () {
                              // Get.to(() => ApplyRegularisationsForEmployeeView());
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ApplyRegularisationView()),
                              );

                              // Navigate to apply view
                            },
                            child: Text("Apply"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const InfoRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              "$title:",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
