import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/disable_pin_controller.dart';

class DisablePinView extends GetView<DisablePinController> {
  const DisablePinView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DisablePinView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DisablePinView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
