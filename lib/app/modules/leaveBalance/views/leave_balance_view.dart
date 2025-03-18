import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/leave_balance_controller.dart';

class LeaveBalanceView extends GetView<LeaveBalanceController> {
  const LeaveBalanceView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LeaveBalanceView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'LeaveBalanceView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
