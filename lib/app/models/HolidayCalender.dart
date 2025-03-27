class HolidayCalendarModel {
  final String status;
  final String message;
  final HolidayData data;

  HolidayCalendarModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory HolidayCalendarModel.fromJson(Map<String, dynamic> json) {
    return HolidayCalendarModel(
      status: json['status'],
      message: json['message'],
      data: HolidayData.fromJson(json['data']),
    );
  }
}


class HolidayData {
  final int year;
  final int totalHolidays;
  final List<Holiday> holidays;

  HolidayData({
    required this.year,
    required this.totalHolidays,
    required this.holidays,
  });

  factory HolidayData.fromJson(Map<String, dynamic> json) {
    return HolidayData(
      year: json['year'],
      totalHolidays: json['total_holidays'],
      holidays: List<Holiday>.from(
        json['holidays'].map((x) => Holiday.fromJson(x)),
      ),
    );
  }
}

class Holiday {
  final String date;
  final String day;
  final String festival;

  Holiday({
    required this.date,
    required this.day,
    required this.festival,
  });

  factory Holiday.fromJson(Map<String, dynamic> json) {
    return Holiday(
      date: json['date'],
      day: json['day'],
      festival: json['festival'],
    );
  }
}
