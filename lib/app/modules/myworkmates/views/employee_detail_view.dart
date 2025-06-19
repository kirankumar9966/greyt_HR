import 'package:flutter/material.dart';


class EmployeeDetailView extends StatelessWidget {
  final Map<String, dynamic> employee;

  const EmployeeDetailView({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("People")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  child: Text(
                    (employee['name'] ?? ' ')[0],
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        employee['name'] ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        employee['id'] ?? '',
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildInfoCard("Extension No", employee['extension'] ?? '-'),
            _buildInfoCard("Location", employee['location'] ?? 'Not available'),
            _buildInfoCard("Job Mode", employee['jobMode'] ?? ''),
            _buildInfoCard("Joining Date", employee['joiningDate'] ?? ''),
            _buildInfoCard("Date Of Birth", employee['dob'] ?? ''),
            _buildInfoCard("Status", employee['status'] ?? ''),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 16)),
      ]),
    );
  }
}
