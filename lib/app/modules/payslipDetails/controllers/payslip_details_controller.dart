import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../services/dashboard_service.dart';

class PayslipDetailsController extends GetxController {
  var isLoading = true.obs;
  var isEarningsExpanded = false.obs;
  var isDeductionsExpanded = false.obs;

  var selectedYear = "2024 - 2025".obs;
  var selectedMonth = "Apr".obs;
  var formattedDate = "".obs;

  var months = <String>[].obs;

  var salaryComponents = <String, dynamic>{}.obs;
  var employeeDetails = <String, String>{}.obs;
  var errorMessage = ''.obs;

  List<String> years = ["2023 - 2024", "2024 - 2025", "2025 - 2026"];
  void toggleEarnings() {
    isEarningsExpanded.value = !isEarningsExpanded.value;
  }

  void toggleDeductions() {
    isDeductionsExpanded.value = !isDeductionsExpanded.value;
  }

  final Map<String, int> monthMap = {
    "Apr": 4, "May": 5, "Jun": 6, "Jul": 7,
    "Aug": 8, "Sep": 9, "Oct": 10, "Nov": 11,
    "Dec": 12, "Jan": 1, "Feb": 2, "Mar": 3,
  };

  @override
  void onInit() {
    super.onInit();
    months.assignAll([
      "Apr", "May", "Jun", "Jul", "Aug", "Sep",
      "Oct", "Nov", "Dec", "Jan", "Feb", "Mar"
    ]);
    selectedMonth.value ;
    _setPreviousMonth();
    fetchSalaryDetails(); // Initial fetch
  }


  void updateMonth(String month) {

    if (selectedMonth.value != month) {
      selectedMonth.value = month; // 👈 This will trigger the UI highlight first

        fetchSalaryDetails(); // 👈 This triggers after UI update
      } // Refetch on month change

  }

  void updateYear(String year) {
    selectedYear.value = year;
    fetchSalaryDetails(); // Refetch on year change
  }

  void _setPreviousMonth() {
    String currentMonth = DateFormat('MMM').format(DateTime.now());
    if (months.contains(currentMonth)) {
      selectedMonth.value = currentMonth;
    } else {
      selectedMonth.value = "Mar";
    }
  }
  String getMonthFullName(String shortMonth) {
    // Convert short month (e.g., "Feb") to full month name (e.g., "February")
    final date = DateFormat("MMM").parse(shortMonth);
    return DateFormat("MMMM").format(date);
  }
  String getPayslipTitle() {
    final month = selectedMonth.value; // e.g., "Feb"
    final year = extractFinancialYear(selectedYear.value, month); // e.g., "2025"
    final fullMonthName = getMonthFullName(month); // e.g., "February"
    return "Payslip for the month of $fullMonthName $year";
  }
  String getFormattedMonthYear() {
    final month = selectedMonth.value; // e.g., "Feb"
    final year = extractFinancialYear(selectedYear.value, month); // e.g., "2025"
    return "$month$year"; // => Feb2025
  }

  String generatePayslipFileName() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return "Payslip_${getFormattedMonthYear()}_$timestamp.pdf";
  }
  /// 🔸 Extracts the correct actual year based on selected FY + month
  String extractActualYear(String selectedFY, String selectedMonth) {
    final parts = selectedFY.split(' - ');
    final startYear = parts[0];
    final endYear = parts[1];

    // Jan to Mar belong to next year in FY
    if (["Jan", "Feb", "Mar"].contains(selectedMonth)) {
      return endYear; // e.g., 2025
    } else {
      return startYear; // e.g., 2024
    }
  }
  String extractFinancialYear(String year, String month) {
    final split = year.split(' - ');
    if (["Jan", "Feb", "Mar"].contains(month)) {
      return split[1]; // e.g., "2025"
    } else {
      return split[0]; // e.g., "2024"
    }
  }
  String formatDate(String? date) {
    if (date == null || date.isEmpty) {
      return '';  // Return empty string if date is null or empty
    }
    try {
      DateTime parsedDate = DateTime.parse(date);  // Assuming hire_date is in string format (yyyy-mm-dd)
      return DateFormat('dd-MM-yyyy').format(parsedDate);
    } catch (e) {
      return '';  // Return empty string if there's an error in date parsing
    }
  }

  /// 🔸 Fetch salary from API based on correct month + actual year
  Future<void> fetchSalaryDetails() async {
    isLoading.value = true;

    final month = selectedMonth.value;  // e.g. "Mar"
    final year = extractFinancialYear(selectedYear.value, month);  // e.g. "2025"

    // Convert month string to "03"
    final formattedMonth = DateFormat("MM").format(DateFormat("MMM").parse(month));
    final monthOfSalary = "$year-$formattedMonth";
    formattedDate.value = "$formattedMonth $selectedYear";
    final response = await DashboardService.payslip(
      month: monthOfSalary, // 🟢 send in "yyyy-MM"
    );
    if (response['status'] == 'success' && response['data'] != null) {
      final data = response['data'];
      final components = data['salary_components'];

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
          "Joining Date": formatDate(data['hire_date']) ?? '',
          "Pan Number": data['pan_number'] ?? '-',
          "Location": data['job_location'] ?? '',
          "PF No": data['pf_no'] ?? '-',
          "PF UAN": data['uan'] ?? '-',
          "Effective Work Days": data['work_days']?.toString() ?? '-',
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
