import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:greyt_hr/app/modules/dashboard/views/dashboard_view.dart';

import '../controllers/edti_pin_controller.dart';

class EdtiPinView extends GetView<EdtiPinController> {
  const EdtiPinView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit 4 Digit PIN',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.black),
            onPressed: () => Get.offAll(() => const DashboardView()),
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
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        Image.asset(
                          'assets/images/Pin.jpg',
                          height: 200,
                          width: 200,
                        ),
                        const SizedBox(height: 30),
                        // Dynamic Title
                        Obx(
                              () => Text(
                            controller.getStepTitle(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Dynamic Subtitle
                        Obx(
                              () => Text(
                            controller.getStepSubtitle(),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.blueGrey.shade400,
                            ),
                            textAlign: TextAlign.center,
                          ),
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
                              child: Obx(
                                    () => TextField(
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
                                    counterText: '',
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: controller.pinMismatch.value
                                            ? Colors.red
                                            : Colors.grey.shade400,
                                        width: 2,
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: controller.pinMismatch.value
                                            ? Colors.red
                                            : Colors.lightBlue,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                      onChanged: (value) {
                                        controller.moveToNextField(index);
                                      },
                                ),
                              ),
                            ),
                            );
                          }),
                        ),
                        const SizedBox(height: 8),
                        // Validation Message
                        Obx(
                              () => Visibility(
                            visible: controller.pinMismatch.value,
                            child: const Text(
                              'Pins do not match. Please try again.',
                              style: TextStyle(color: Colors.red, fontSize: 14),
                            ),
                          ),
                        ),
                        const Spacer(),
                        // Cancel and Dynamic Button
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.blue, fontSize: 16),
                                ),
                              ),
                              Obx(
                                    () => ElevatedButton(
                                  onPressed: controller.isButtonEnabled.value
                                      ? () {
                                    if (controller.step.value < 2) {
                                      controller.advanceToNextStep();
                                    } else {
                                      controller.handleSuccess();
                                    }
                                  }
                                      : null,
                                  child: Text(controller.getButtonText()),
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
