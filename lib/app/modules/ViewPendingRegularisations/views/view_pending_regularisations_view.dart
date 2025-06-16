import 'package:flutter/material.dart';
import 'package:greyt_hr/app/modules/RegularisationHistoryDetailsPage/views/regularisation_history_details_page_view.dart';
import 'package:greyt_hr/app/modules/ViewPendingRegularisations/controllers/view_pending_regularisations_controller.dart';

class ViewPendingRegularisationsView extends StatelessWidget {
  const ViewPendingRegularisationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final ViewPendingRegularisationsController controller = ViewPendingRegularisationsController();

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
      body: Column(
        children: [
          // Tabs
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                controller.buildTabButton(context, 'Apply', false, 'apply'),
                controller.buildTabButton(context, 'Pending', true, 'pending'),
                controller.buildTabButton(context, 'History', false, 'history'),
              ],
            ),
          ),

          // List or Empty State
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: controller.fetchPendingRegularisation(),  // Replace with your async data fetch method
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return  Expanded(
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
                            'Pending requests will appear here.',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final historyList = snapshot.data!;

                return ListView.builder(
                  itemCount: historyList.length,
                  itemBuilder: (context, index) {
                    final history = historyList[index];
                    final status = history.statusLabel.toLowerCase();
                    final isRejected = status == 'rejected';
                    final bgColor = isRejected ? Colors.red.shade50 : Colors.grey.shade200;
                    final borderColor = isRejected ? Colors.red : Colors.grey;
                    final textColor = isRejected ? Colors.red : Colors.black87;


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
                              // Header
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      "${controller.capitalize(history.ManagerFirstName)} ${controller.capitalize(history.ManagerLastName)}",
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                                      history.statusLabel,
                                      style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              const Text('Pending With', style: TextStyle(color: Colors.grey)),
                              const SizedBox(height: 12),

                              // Entries (with type check)
                              if (history.regularisationEntries is Iterable)
                                ...List<Widget>.from((history.regularisationEntries as Iterable).map((entry) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.formatDateWithSuffix(entry.date),
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                      ),
                                      const Text("Applied Date(s)", style: TextStyle(color: Colors.grey)),
                                      const SizedBox(height: 12),
                                    ],
                                  );
                                })),

                              // Footer
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.formatDateWithSuffix(history.created_at),
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                      ),
                                      const Text("Applied on", style: TextStyle(color: Colors.grey)),
                                    ],
                                  ),
                                  Text(
                                    "1",
                                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 12),

                              // Action Buttons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  OutlinedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => RegularisationDetailsPageView(
                                            id: history.id,
                                            token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjE2OC4xLjM4OjgwMDAvYXBpL2xvZ2luIiwiaWF0IjoxNzUwMDcyNDMxLCJleHAiOjE3NTAwNzk2MzEsIm5iZiI6MTc1MDA3MjQzMSwianRpIjoicThuMGRUSXZqS1JlWXNhRCIsInN1YiI6IlhTUy0wMzA3IiwicHJ2IjoiMzRjNDhmOTlmOTNhZWI3Nzc4YjkyZGEyNWZkNTYyYTI2ODVjYjYyNiJ9.UxPgjmT_-al3yuGlEonMwkH913QKEdTZeN11hKWOPDc", // pass real token or fetch dynamically
                                          ),
                                        ),
                                      );
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
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                            title: const Text("Withdraw Regularization", textAlign: TextAlign.center),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Image.asset(
                                                  'assets/images/withdraw_illustration.png',
                                                  height: 100,
                                                ),
                                                const SizedBox(height: 20),
                                                const Text(
                                                  "Are you sure you want to withdraw the regularization?",
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                            actionsAlignment: MainAxisAlignment.center,
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  controller.withdrawRegularization(context, history.id);
                                                  Navigator.pop(context);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.blue,
                                                  foregroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                                ),
                                                child: const Text("Confirm"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                    ),
                                    child: const Text("Withdraw"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
