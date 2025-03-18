import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:greyt_hr/app/modules/dashboard/views/dashboard_view.dart';

import '../controllers/resign_controller.dart';

class ResignView extends GetView<ResignController> {
  const ResignView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resignation"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Get.to(() => DashboardView());
            },
          ),
        ],
        foregroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/undraw_page-not-found_6wni.png',
              height: 180,width: 180,),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "We're sorry! ",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "😔", // Pensive Face emoji
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Text('Our server is taking some time to get ready. We re on it and will be back soon',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.blueGrey),  ),
            ],
          ),
        ),
      )
    );
  }
}
