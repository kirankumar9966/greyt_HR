import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PayslipDetailsController extends GetxController {
  //TODO: Implement PayslipDetailsController
  var isEarningsExpanded = false.obs;
  var isDeductionsExpanded = false.obs;

  var selectedYear = "2025 - 2026".obs;
  var selectedMonth = "".obs;
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


  List<String> years = ["2023 - 2024", "2024 - 2025", "2025 - 2026"];

  void _setPreviousMonth() {
    String currentMonth = DateFormat('MMM').format(DateTime.now()); // e.g., "Apr"
    if (months.contains(currentMonth)) {
      selectedMonth.value = currentMonth; // ✅ Set current month dynamically
    } else {
      selectedMonth.value = "Jan"; // Default fallback
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
    months.assignAll(["Nov", "Dec", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct"]);
    _setPreviousMonth(); // ✅ Call AFTER months are assigned
  }

  void updateMonth(String month) {
    selectedMonth.value = month; // ✅ Updates selected month dynamically
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
