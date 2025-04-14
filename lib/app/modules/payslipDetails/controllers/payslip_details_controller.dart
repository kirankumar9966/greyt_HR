import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../services/dashboard_service.dart';

class PayslipDetailsController extends GetxController {
  //TODO: Implement PayslipDetailsController
  var isEarningsExpanded = false.obs;
  var isDeductionsExpanded = false.obs;
  var isLoading = true.obs;
  var selectedYear = "2025 - 2026".obs;
  var selectedMonth = "Feb".obs;
  var months = <String>[].obs;

  final Map<String, String> employeeDetails = {
    "Name": "Obula Kiran Kumar",
    "Employee No": "XSS-0474",
    "Joining Date": "02 Jan 2023",
    "Bank Name": "ICICI",
    "Designation": "Software Engineer",
    "Bank Account Number": "06327838232387",
    "Department": "Technology",
    "Pan Number": "LAAPK2322F",
    "Location": "Hyderabad",
    "PF No": "APHYD98237216328727776",
    "Effective Work Days": "- - -",
    "PF UAN": "10192883388737",
    "LOP": "0.000",
  };


  Future<void> fetchSalaryDetails() async{
    isLoading.value = true;
    final response = await DashboardService.payslip();


    if (response['status'] == 'success') {
      final data = response['data'];
      final components = data['salary_components'];

      // errorMessage.value = '';
      isLoading.value = false;
    } else {
      // errorMessage.value = response['message'] ?? 'Failed to fetch payslip';
    }

    isLoading.value = false;


  }


  List<String> years = ["2023 - 2024", "2024 - 2025", "2025 - 2026"];

  void _setPreviousMonth() {
    String currentMonth = DateFormat('MMM').format(DateTime.now()); // Current month in "Jan" format
    int currentIndex = months.indexOf(currentMonth);

    if (currentIndex > 0) {
      selectedMonth.value = months[currentIndex - 1]; // Highlight previous month
    } else {
      selectedMonth.value = "Dec"; // If January, set December by default
    }
  }

  void updateYear(String year) {
    selectedYear.value = year;
  }



  void toggleEarnings() {
    isEarningsExpanded.value = !isEarningsExpanded.value;
  }

  void toggleDeductions() {
    isDeductionsExpanded.value = !isDeductionsExpanded.value;
  }
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    _setPreviousMonth();
    fetchSalaryDetails();
    months.assignAll(["Nov", "Dec", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct"]);

  }
  void updateMonth(String month) {
    selectedMonth.value = month; // ✅ Correctly updating the observable value
  }
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
