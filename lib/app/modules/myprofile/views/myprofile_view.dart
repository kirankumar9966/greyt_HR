import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/myprofile_controller.dart';

class MyprofileView extends GetView<MyprofileController> {
  const MyprofileView({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('MyprofileView'),
//         centerTitle: true,
//       ),
//       body: const Center(
//         child: Text(
//           'MyprofileView is working',
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//     );
//   }
// }
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isResignationScreen.value
        ? buildResignationScreen()
        : buildProfileScreen());
  }

  // My Profile Screen
  Widget buildProfileScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        leading: BackButton(),
        actions: [
          IconButton(icon: Icon(Icons.home), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blue[700],
            width: double.infinity,
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Text('PV', style: TextStyle(color: Colors.black)),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(controller.name, style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                    Text(controller.empCode, style: TextStyle(color: Colors.white70)),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          buildInfoTile('Extension No', controller.extension),
          buildInfoTile('Location', controller.location),
          buildInfoTile('Job Mode', controller.jobMode),
          buildInfoTile('Joining Date', controller.joiningDate),
          buildInfoTile('Date Of Birth', controller.dob),
          buildInfoTile('Status', controller.status),
          SizedBox(height: 10),
          ListTile(
            title: Text('Resign', style: TextStyle(color: Colors.red)),
            trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.red),
            onTap: controller.showResignationPage,
          )
        ],
      ),
    );
  }

  // Resignation Page (404 screen)
  Widget buildResignationScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resignation'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: controller.goBack,
        ),
        actions: [
          IconButton(icon: Icon(Icons.home), onPressed: () {}),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('4️⃣4️⃣', style: TextStyle(fontSize: 50)),
            SizedBox(height: 20),
            Text('We\'re sorry! 😔', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                'Our server is taking some time to get ready. We’re on it and will be back soon.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoTile(String label, String value) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
          SizedBox(height: 5),
          Text(value, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

