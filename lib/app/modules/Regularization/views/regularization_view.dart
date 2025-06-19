// import 'package:flutter/material.dart';
//
// import 'package:get/get.dart';
//
// import '../controllers/regularization_controller.dart';
//
// class RegularizationView extends GetView<RegularizationController> {
//   const RegularizationView({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('RegularizationView'),
//         centerTitle: true,
//       ),
//       body: const Center(
//         child: Text(
//           'RegularizationView is working',
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greyt_hr/app/modules/regularization/controllers/regularization_controller.dart';

/// The complete Regularization View, including all tab methods.
class RegularizationView extends GetView<RegularizationController> {
  const RegularizationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Show the main page if showMainPage is true, otherwise show the tab layout.
      return controller.showMainPage.value
          ? _buildMainPage()
          : _buildTabLayout();
    });
  }

  /// Main Page: Displays two buttons (View Pending & Apply)
  Widget _buildMainPage() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Apply Regularization"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(), // Back navigation
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Regularization",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () =>
                        controller.goToTabs(RegularizationTab.pending),
                    child: const Text("View Pending"),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () =>
                        controller.goToTabs(RegularizationTab.apply),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("Apply"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Tab Layout: Contains three tabs: Apply, Pending, History
  Widget _buildTabLayout() {
    int initialIndex = _tabToIndex(controller.selectedTab.value);

    return DefaultTabController(
      length: 3,
      initialIndex: initialIndex,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Regularization"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: controller.goToMainPage,
          ),
          bottom: TabBar(
            onTap: (index) {
              controller.selectedTab.value = _indexToTab(index);
            },
            tabs: const [
              Tab(text: "Apply"),
              Tab(text: "Pending"),
              Tab(text: "History"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildApplyTab(),    // Ensure this method is defined below.
            _buildPendingTab(),  // Ensure this method is defined below.
            _buildHistoryTab(),  // Ensure this method is defined below.
          ],
        ),
      ),
    );
  }

  /// Apply Tab (Example Calendar UI)
  Widget _buildApplyTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Instruction row.
          Row(
            children: const [
              Icon(Icons.info, color: Colors.orange),
              SizedBox(width: 8),
              Text(
                "Tap on date to select",
                style: TextStyle(color: Colors.orange),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Calendar container.
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              children: [
                const Text(
                  "March 2025",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                _buildCalendar(), // Calendar widget.
              ],
            ),
          ),
          const SizedBox(height: 16),
          // "Show Legend" button.
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                // Add legend logic here.
              },
              child: const Text("Show Legend"),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Yay! No Exception Days.",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  /// Simple calendar for March 2025 using GridView.
  Widget _buildCalendar() {
    final days = List.generate(31, (index) => index + 1);
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        childAspectRatio: 1,
      ),
      itemCount: days.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // Implement date selection logic if needed.
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text('${days[index]}'),
          ),
        );
      },
    );
  }

  /// Pending Tab (Placeholder UI)
  Widget _buildPendingTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Placeholder colored squares.
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _coloredSquare(Colors.orange),
              const SizedBox(width: 8),
              _coloredSquare(Colors.purple),
              const SizedBox(width: 8),
              _coloredSquare(Colors.black),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            "Nothing to show!",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  /// History Tab (Placeholder UI)
  Widget _buildHistoryTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Example icon with an overlay.
          Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.work, size: 80, color: Colors.orange),
              Positioned(
                bottom: 0,
                right: 0,
                child: Icon(Icons.access_time, size: 24, color: Colors.purple),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            "Nothing to show!",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  /// Helper: Convert enum to tab index.
  int _tabToIndex(RegularizationTab tab) {
    switch (tab) {
      case RegularizationTab.apply:
        return 0;
      case RegularizationTab.pending:
        return 1;
      case RegularizationTab.history:
        return 2;
    }
  }

  /// Helper: Convert tab index to enum.
  RegularizationTab _indexToTab(int index) {
    switch (index) {
      case 0:
        return RegularizationTab.apply;
      case 1:
        return RegularizationTab.pending;
      case 2:
        return RegularizationTab.history;
      default:
        return RegularizationTab.apply;
    }
  }

  /// Helper: Create a colored square.
  Widget _coloredSquare(Color color) {
    return Container(
      width: 30,
      height: 30,
      color: color,
    );
  }
}



