import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/apply_regularization_controller.dart';

class ApplyRegularizationView extends GetView<ApplyRegularizationController> {
  const ApplyRegularizationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ApplyRegularizationView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ApplyRegularizationView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
