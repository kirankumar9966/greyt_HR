import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:greyt_hr/app/modules/applyRegularisationScreen/controllers/apply_regularisation_screen_controller.dart';
import 'package:greyt_hr/app/modules/profile/controllers/profile_controller.dart';
import 'package:greyt_hr/app/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class RegularizationScreen extends StatefulWidget {
  final Set<DateTime> selectedDates;

  const RegularizationScreen({Key? key, required this.selectedDates}) : super(key: key);

  @override
  State<RegularizationScreen> createState() => _RegularizationScreenState();
}

class _RegularizationScreenState extends State<RegularizationScreen> {
  late List<DateTime> _dates;
  final profileController = Get.put(ProfileController());
  String? employeeId;
  String? empId;
  final Map<DateTime, TextEditingController> _startControllers = {};
  final Map<DateTime, TextEditingController> _endControllers = {};
  final Map<DateTime, TextEditingController> _reasonControllers = {};
  final TextEditingController _remarksController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dates = widget.selectedDates.toList();
    _initializeControllers();
    fetchEmployeeId().then((id) {
      setState(() {
        empId = id;
      });
    });

  }


  void _initializeControllers() {
    for (var date in _dates) {
      _startControllers[date] = TextEditingController(text: '10:00');
      _endControllers[date] = TextEditingController(text: '19:00');
      _reasonControllers[date] = TextEditingController();
    }
  }


  Future<String?> fetchEmployeeId() async {
    final response = await http.get(
      Uri.parse('http://192.168.1.48:8000/api/getEmployeeDetails'),
      headers: {
        'Accept': 'application/json',
        // Add auth header if needed
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Employee data: $data');
      return data['emp_id']; // or adjust based on your actual structure
    } else {
      print('Failed to load employee details');
      return null;
    }
  }


  @override
  void dispose() {
    _remarksController.dispose();
    for (var c in _startControllers.values) c.dispose();
    for (var c in _endControllers.values) c.dispose();
    for (var c in _reasonControllers.values) c.dispose();
    super.dispose();
  }

  Future<void> onApplyPressed() async {


    final client = http.Client();
    final token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjE2OC4xLjM4OjgwMDAvYXBpL2xvZ2luIiwiaWF0IjoxNzUwMDcyNDMxLCJleHAiOjE3NTAwNzk2MzEsIm5iZiI6MTc1MDA3MjQzMSwianRpIjoicThuMGRUSXZqS1JlWXNhRCIsInN1YiI6IlhTUy0wMzA3IiwicHJ2IjoiMzRjNDhmOTlmOTNhZWI3Nzc4YjkyZGEyNWZkNTYyYTI2ODVjYjYyNiJ9.UxPgjmT_-al3yuGlEonMwkH913QKEdTZeN11hKWOPDc'; // Replace with secure storage later
    print('bhavana and bhnau');
    List<Map<String, dynamic>> entries = _dates.map((date) {
      return {
        'date': DateFormat('yyyy-MM-dd').format(date),
        'from': _startControllers[date]?.text ?? '',
        'to': _endControllers[date]?.text ?? '',
        'reason': _reasonControllers[date]?.text ?? '',
      };
    }).toList();

    final body = {
      'emp_id':   AuthService.getEmpId()
      ,
      'employee_remarks': _remarksController.text,
      'regularisation_entries': jsonEncode(entries),
      'is_withdraw': 0,
      'status': 5,
    };

    final uri = Uri.parse('http://192.168.1.38:8000/api/regularisation-apply');

    try {
      final request = http.Request('POST', uri)
        ..headers.addAll({
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        })
        ..body = jsonEncode(body);

      final response = await http.Response.fromStream(await client.send(request));

      print('📨 Status Code: ${response.statusCode}');
      print('🧾 Response Body: ${response.body}');
    } catch (e) {
      print('❌ Error submitting: $e');
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Regularization'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.home_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _headerRow(),
            const SizedBox(height: 12),
            _selectedUserTile(),
            const SizedBox(height: 12),
            _remarksField(),
            const SizedBox(height: 20),
            ..._dates.map((date) => Column(
              children: [
                _dateTile(date),
                const SizedBox(height: 20),
              ],
            )),

            _actionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _headerRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Applying to", style: TextStyle(fontWeight: FontWeight.w500)),
        TextButton(onPressed: () {}, child: const Text("Clear All")),
      ],
    );
  }

  Widget _selectedUserTile() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/profile.png'),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text.rich(
              TextSpan(
                text: 'GYAN PRABODH DASARI ',
                style: const TextStyle(fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: '(XSS-0307)',
                    style: TextStyle(fontWeight: FontWeight.normal, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _remarksField() {
    return TextFormField(
      controller: _remarksController,
      maxLines: 2,
      decoration: const InputDecoration(
        labelText: 'Remarks',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _dateTile(DateTime date) {
    final formattedDate = DateFormat('d MMM yyyy').format(date);
    final weekday = DateFormat('EEE').format(date);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$formattedDate\n$weekday',
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13, height: 1.3),
          ),
          const SizedBox(height: 4),
          const Text('10:00 AM To 07:00 PM Shift', style: TextStyle(fontSize: 12)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _timeField(_startControllers[date]!)),
              const SizedBox(width: 8),
              Expanded(child: _timeField(_endControllers[date]!)),
            ],
          ),
          const SizedBox(height: 8),
          _reasonField(_reasonControllers[date]!),
        ],
      ),
    );
  }

  Widget _timeField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 12),
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 12),
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.access_time),
      ),
    );
  }

  Widget _reasonField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      maxLines: 2,
      decoration: const InputDecoration(
        labelText: 'Reason',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _actionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            onPressed: onApplyPressed,
            child: const Text("Apply"),
          ),
        ),
      ],
    );
  }
}
