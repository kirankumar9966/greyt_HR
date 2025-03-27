import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:greyt_hr/app/modules/engage/models/engage_model.dart';
import 'package:greyt_hr/app/services/auth_service.dart';

import '../../footer/views/footer_view.dart';


class EngageView extends StatefulWidget {
  const EngageView({super.key});

  @override
  State<EngageView> createState() => _EngageViewState();
}

class _EngageViewState extends State<EngageView> {
  String selectedActivity = "All Activities"; // Default selection
  String selectedSort = "All Feeds"; // Default sorting
  String selectedGroup = "Groups";
  String selectedLocation = "Doddaballapur";
  String selectedDepartment = "Admin";
  List<Datum> feedList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFeedData();
  }

  Future<void> fetchFeedData() async {
    const String apiUrl = 'https://s6.payg-india.com/api/getfeed';

    try {
      final token = AuthService.getToken();
      if (token == null) {
        throw Exception("No token found. Please log in again.");
      }

      print("🔐 Token used: $token");

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({}), // Send an empty body or add filters here
      );

      print("🌐 Status Code: ${response.statusCode}");
      print("📦 Raw Response: ${response.body}");

      if (response.statusCode == 200) {
        try {
          final engage = engageFromJson(response.body);
          setState(() {
            feedList = engage.data;
            isLoading = false;
          });
        } catch (e) {
          print("⚠️ JSON Parsing Error: $e");
          setState(() => isLoading = false);
          _showMessage("Invalid data format from server.");
        }
      } else {
        setState(() => isLoading = false);
        _showMessage("Failed to load feed: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("❌ Error fetching feed: $e");
      setState(() => isLoading = false);
      _showMessage("Error fetching feed: $e");
    }
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Engage'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : feedList.isEmpty
          ? const Center(child: Text("No data available."))
          : Column(
        children: [
          // Dropdown Row
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Activity Dropdown
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _showAlertDialog(context, "Select Activity", true);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Activity:"),
                          Text(selectedActivity),
                          const Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                // Group Dropdown
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _showSelectionDialog(context, "Select an Option");
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Group:"),
                          Text(selectedSort.isNotEmpty ? selectedSort : "Select"),
                          const Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Feed List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: feedList.length,
              itemBuilder: (context, index) {
                return buildFeedCard(feedList[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
      bottomNavigationBar: FooterView(),
    );

  }
  void _showSelectionDialog(BuildContext context, String title) {
    // Define categorized options.
    Map<String, List<String>> categorizedOptions = {
      "Groups": [
        "All Feeds",
        "Every One",
        "Events",
        "Company News",
        "Appreciation"
      ],
      "Location": [
        "India",
        "Adilabad",
        "Doddaballapur",
        "Guntur",
        "Hoskote",
        "Hyderabad",
        "Mandya",
        "Mangalore",
        "Mumbai",
        "Mysore",
        "Pune",
        "Sirsi",
        "Thumkur",
        "Tirupati",
        "Trivandrum",
        "Udaipur",
        "Vijayawada",
        "USA",
        "California",
        "New York",
        "Hawaii"
      ],
      "Department": [
        "HR",
        "Operations",
        "Production Team",
        "QA",
        "Sales Team",
        "Testing Team"
      ]
    };

    // Flatten all options into a single list for selection handling
    List<String> options = categorizedOptions.values.expand((list) => list).toList();

    // Current selected value
    String currentValue = selectedSort.isNotEmpty ? selectedSort : "All Feeds";


    // Temporary selection variable.
    String localTempSelection = currentValue;

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: StatefulBuilder(
            builder: (context, setStateDialog) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title and Close Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.close,
                            size: 24,
                            color: Colors.grey,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const Divider(),
                    // Scrollable Container for categorized options
                    Container(
                      constraints: const BoxConstraints(
                        maxHeight: 400, // Adjust max height as needed
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: categorizedOptions.entries.map((entry) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Category Title
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 12),
                                  child: Text(
                                    entry.key, // Group, Location, or Department
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                                // List of Options under each category
                                ...entry.value.map((option) {
                                  return RadioListTile<String>(
                                    title: Text(option),
                                    value: option,
                                    groupValue: localTempSelection,
                                    onChanged: (value) {
                                      setStateDialog(() {
                                        localTempSelection = value!;
                                      });
                                    },
                                    activeColor: const Color(0xFF5473e3),
                                  );
                                }).toList(),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Confirm Button aligned to the right.
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5473e3),
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onPressed: () {
                          // Update the selectedSort state.
                          setState(() {
                            selectedSort = localTempSelection;
                          });
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Confirm",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
  void _showAlertDialog(BuildContext context, String title, bool isActivity) {
    // Initialize a local temporary selection with the current value.
    String localTempSelection = isActivity ? selectedActivity : selectedSort;
    // Define options based on isActivity.
    List<String> options = isActivity
        ? ["All Activities","Posts", "Kudos","Polls"]
        : ["Newest First", "Oldest First"];

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: StatefulBuilder(
            builder: (context, setStateDialog) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Keeps pop-up compact
                  children: [
                    // Title & Close Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: Icon(Icons.close,
                              size: 24, color: Colors.grey),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    Divider(),
                    // Container wrapping all radio options with a single border
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Radio options list
                          Column(
                            children: options.map((option) {
                              return RadioListTile<String>(
                                title: Text(option),
                                value: option,
                                groupValue: localTempSelection,
                                onChanged: (value) {
                                  setStateDialog(() {
                                    localTempSelection = value!;
                                  });
                                },
                                activeColor: Color(0xFF5473e3),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 80),
                          // Confirm Button aligned to the right with reduced size and custom color
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF5473e3), // Custom color #5473e3
                                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20), // Reduced size
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (isActivity) {
                                    selectedActivity = localTempSelection;
                                  } else {
                                    selectedSort = localTempSelection;
                                  }
                                });
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Confirm",
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )


                    // Spacer: 200 margin-top before confirm button.


                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
  Widget buildFeedCard(Datum post) {
    final String initials = post.employee.name.isNotEmpty
        ? post.employee.name.split(" ").map((e) => e[0]).take(2).join()
        : "?";

    final String? base64Image = post.employee.image;
    late Widget imageWidget;

    try {
      if (base64Image != null && base64Image.isNotEmpty) {
        final decodedBytes = base64Decode(base64Image);
        imageWidget = Image.memory(
          decodedBytes,
          fit: BoxFit.cover,
          width: 70,
          height: 70,
          errorBuilder: (context, error, stackTrace) {
            return _buildInitials(initials);
          },
        );
      } else {
        imageWidget = _buildInitials(initials);
      }
    } catch (_) {
      imageWidget = _buildInitials(initials);
    }

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header image (static company image)
            Image.network(
              "https://xsilica.com/images/xsilica_broucher_final_modified_05082016-2.png",
              width: 100,
              height: 50,
            ),

            const SizedBox(height: 10),
            Text(post.time, style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 8),
            Text(post.message, style: const TextStyle(fontSize: 15)),
            const SizedBox(height: 20),

            Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 300,
                    height: 70,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFBD6F0),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  Positioned(
                    bottom: -25,
                    left: 300 / 2 - 35,
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.pink, width: 2),
                      ),
                      child: ClipOval(child: imageWidget),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            Center(
              child: Text(
                post.type == Type.DATE_OF_BIRTH
                    ? "🎂 Happy Birthday"
                    : "🎉 Work Anniversary",
                style: const TextStyle(fontSize: 14),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                post.employee.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildActionButton(Icons.thumb_up, "React"),
                buildActionButton(Icons.comment, "Comment"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget fallbackImage() {
    return Image.network(
      "https://xsilica.com/images/xsilica_broucher_final_modified_05082016-2.png",
      width: double.infinity,
      height: 150,
      fit: BoxFit.cover,
    );
  }


  Widget _buildInitials(String initials) {
    return Center(
      child: Text(
        initials.toUpperCase(),
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.pink,
        ),
      ),
    );
  }


  Widget buildActionButton(IconData icon, String label) {
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: Colors.black),
      label: Text(label, style: const TextStyle(color: Colors.black)),
    );
  }



  Widget _buildFloatingActionButton() {
    return SpeedDial(
      icon: Icons.add, // Shows "+" by default
      activeIcon: Icons.close, // Turns into "×" when expanded
      backgroundColor: Colors.blue,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      elevation: 8.0,
      animationAngle: 180, // Optional for rotation effect
      children: [
        SpeedDialChild(
          child: const Icon(Icons.thumb_up, color: Colors.white),
          backgroundColor: Colors.green,
          label: 'Kudos',
          labelStyle: const TextStyle(fontSize: 16.0),
          onTap: () => print('Kudos Button Clicked'),
        ),
        SpeedDialChild(
          child: const Icon(Icons.poll, color: Colors.white),
          backgroundColor: Colors.orange,
          label: 'Polls',
          labelStyle: const TextStyle(fontSize: 16.0),
          onTap: () => print('Polls Button Clicked'),
        ),
      ],
    );
  }

}
