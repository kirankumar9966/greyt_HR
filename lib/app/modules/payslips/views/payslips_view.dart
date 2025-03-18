import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:greyt_hr/app/modules/dashboard/views/dashboard_view.dart';
import 'package:greyt_hr/app/modules/payslipDetails/views/payslip_details_view.dart';

import '../controllers/payslips_controller.dart';

class PayslipsView extends GetView<PayslipsController> {
  const PayslipsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Payslips'),
          // centerTitle: true,
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
        ),
        body: Container(
          color: Colors.grey[50],
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(15),
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1, color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Payslip",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w600),
                        ),
                        Text("RS 22,455.00",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.lightGreen,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Get.to(PayslipDetailsView());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(20), // Rounded button
                                side: const BorderSide(
                                  color: Colors.black, // Border color
                                  width: 1, // Border width
                                )
                              ),

                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 8,
                              ), // Padding for
                            ),
                            child: const Text(
                              "View More",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            )),

                        ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF607D8B),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(20), // Rounded button
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 8,
                              ), // Padding for
                            ),
                            child: const Text(
                              "Download",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ))
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 2,),

              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(15),
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1, color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text("Reimbursement payslip", style: TextStyle(
                    fontSize: 14,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w600)
                        ,)
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/no payslip found.avif',width: 80,height: 80,)
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                       Text("No payslip found for the selected month", style: TextStyle(
                           fontSize: 14,
                           color: Colors.blueGrey,
                           fontWeight: FontWeight.w400)
                       ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
