import 'dart:convert';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../services/dashboard_service.dart';

class PayslipDetailsController extends GetxController {
  var isEarningsExpanded = false.obs;
  var isDeductionsExpanded = false.obs;
  var isLoading = true.obs;

  var selectedYear = "2025 - 2026".obs;
  var selectedMonth = "Feb".obs;

  var months = <String>[].obs;

  var salaryComponents = <String, dynamic>{}.obs;
  var employeeDetails = <String, String>{}.obs;

  var errorMessage = ''.obs;

  List<String> years = ["2023 - 2024", "2024 - 2025", "2025 - 2026"];

  @override
  void onInit() {
    super.onInit();
    months.assignAll([
      "Apr", "May", "Jun", "Jul", "Aug", "Sep",
      "Oct", "Nov", "Dec", "Jan", "Feb", "Mar"
    ]);
    _setPreviousMonth();
    fetchSalaryDetails(); // Initial fetch based on default month/year
  }

  void toggleEarnings() {
    isEarningsExpanded.value = !isEarningsExpanded.value;
  }

  void toggleDeductions() {
    isDeductionsExpanded.value = !isDeductionsExpanded.value;
  }

  void updateMonth(String month) {
    selectedMonth.value = month;
    fetchSalaryDetails(); // Fetch when month changes
  }

  void updateYear(String year) {
    selectedYear.value = year;
    fetchSalaryDetails(); // Fetch when year changes
  }

  void _setPreviousMonth() {
    String currentMonth = DateFormat('MMM').format(DateTime.now());
    if (months.contains(currentMonth)) {
      selectedMonth.value = currentMonth;
    } else {
      selectedMonth.value = "Mar";
    }
  }

  String extractFinancialYear(String year, String month) {
    // Example input: "2024 - 2025", month = "Feb" → return 2025
    final split = year.split(' - ');
    if (["Jan", "Feb", "Mar"].contains(month)) {
      return split[1]; // second part of financial year
    } else {
      return split[0]; // first part of financial year
    }
  }

  Future<void> fetchSalaryDetails() async {
    isLoading.value = true;

    final month = selectedMonth.value;
    final year = extractFinancialYear(selectedYear.value, month);

    final response = await DashboardService.payslip(
      month: month,
      year: year,
    );

    if (response['status'] == 'success' && response['data'] != null) {
      final data = response['data'];
      final components = data['salary_components'];

      // ✅ Check if critical data is missing or null (like net_pay)
      if (components == null || components['net_pay'] == null) {
        errorMessage.value = 'Payslip not available for the selected month.';
        salaryComponents.clear();
        employeeDetails.clear();
      } else {
        salaryComponents.assignAll({
          "earnings": {
            "earnings": components['earnings'] ?? {},
            "basic": components['basic'] ?? 0,
            "hra": components['hra'] ?? 0,
            "conveyance": components['conveyance'] ?? 0,
            "medical_allowance": components['medical_allowance'] ?? 0,
            "special_allowance": components['special_allowance'] ?? 0,
          },
          "deductions": {
            "pf": components['pf'] ?? 0,
            "esi": components['esi'] ?? 0,
            "professional_tax": components['professional_tax'] ?? 0,
          },
          "summary": {
            "gross": components['gross'] ?? 0,
            "net_pay": components['net_pay'] ?? 0,
          }
        });

        employeeDetails.assignAll({
          "Name": "${data['first_name'] ?? ''} ${data['last_name'] ?? ''}",
          "Employee No": "${data['employee_id'] ?? ''}",
          "Bank Name": data['bank_name'] ?? '',
          "Bank Account Number": data['account_number'] ?? '',
          "Designation": data['job_role'] ?? '',
          "Department": data['department'] ?? '',
          "Joining Date": data['hire_date'] ?? '',
          "Pan Number": data['pan_number'] ?? '-',
          "Location": data['job_location'] ?? '',
          "PF No": data['pf_no'] ?? '-',
          "PF UAN": data['uan'] ?? '-',
          "Effective Work Days": data['work_days']?.toString() ?? '',
          "LOP": data['lop']?.toString() ?? '0.000',
        });

        errorMessage.value = '';
      }
    } else {
      errorMessage.value = response['message'] ?? 'Failed to fetch payslip.';
      salaryComponents.clear();
      employeeDetails.clear();
    }

    isLoading.value = false;
  }

}
