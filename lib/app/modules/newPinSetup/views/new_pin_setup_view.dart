import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:greyt_hr/app/modules/dashboard/views/dashboard_view.dart';

import '../controllers/new_pin_setup_controller.dart';

class NewPinSetupView extends GetView<NewPinSetupController> {
  const NewPinSetupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Enable 4 Digit PIN',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.black),
            onPressed: () {
              Get.to(() => const DashboardView());
            },
          ),
        ],
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        // Illustration
                        Center(
                          child: Image.asset(
                            'assets/images/Pin.jpg', // Replace with your illustration asset
                            height: 200,
                            width: 200,
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Title
                        const Text(
                          'Set a new 4 digit PIN',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        // Subtitle
                         Text(
                          'This PIN will be used to access the greytHR app',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blueGrey.shade400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),
                        // PIN Input
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(4, (index) {
                            return SizedBox(
                              width: 50,
                              child: RawKeyboardListener(
                                focusNode: FocusNode(),
                                onKey: (event) {
                                  if (event.runtimeType.toString() ==
                                      'RawKeyDownEvent' &&
                                      event.logicalKey ==
                                          LogicalKeyboardKey.backspace &&
                                      controller.controllers[index].text.isEmpty) {
                                    // Move to the previous field when backspace is pressed and the field is empty
                                    controller.moveToPreviousField(index);
                                  }
                                },
                                child: TextField(
                                  controller: controller.controllers[index],
                                  focusNode: controller.focusNodes[index],
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  maxLength: 1,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                  decoration: InputDecoration(
                                    counterText: '', // Removes the character counter
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade400,
                                        width: 2,
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.lightBlue,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      // Move to the next field when a number is entered
                                      controller.moveToNextField(index);
                                    }
                                  },
                                ),
                              ),
                            );
                          }),
                        ),
                        const Spacer(),
                        // Cancel and Next Buttons
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Cancel',
                                  style:
                                  TextStyle(color: Colors.blue, fontSize: 16),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (controller.isPinComplete()) {
                                    // Save or validate the PIN
                                    print('PIN entered: ${controller.getPin()}');
                                  } else {
                                    Get.snackbar(
                                      'Error',
                                      'Please enter a 4-digit PIN.',
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.redAccent,
                                      colorText: Colors.white,
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 12),
                                  child: Text(
                                    'Next',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
