import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DocumentcenterController extends GetxController {
  var isOpen = <String, bool>{}.obs;

  final documentData = <String, List<String>>{
    'Documents': ['Previous Employment'],
    'Payslips': ['2022', '2023', '2024'],
    'Form 16': [],
    'Company Policies': [],
    'Forms': ['General Forms'],
    'Letters': ['Appointment Letter'],
  }.obs;

  final icons = {
    'Documents': Icons.archive_outlined,
    'Payslips': Icons.receipt_long,
    'Form 16': Icons.description_outlined,
    'Company Policies': Icons.folder_open,
    'Forms': Icons.picture_as_pdf,
    'Letters': Icons.markunread_mailbox_outlined,
  };

  final iconColors = {
    'Documents': Colors.purple,
    'Payslips': Colors.orange,
    'Form 16': Colors.pink,
    'Company Policies': Colors.redAccent,
    'Forms': Colors.deepOrange,
    'Letters': Colors.teal,
  };

  void toggleTile(String title) {
    isOpen[title] = !(isOpen[title] ?? false);
  }
}
