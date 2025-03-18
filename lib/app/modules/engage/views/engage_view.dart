import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/engage_controller.dart';

class EngageView extends GetView<EngageController> {
  const EngageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EngageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EngageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
