import 'dart:convert';

HolidayCalendarModel holidayCalendarModelFromJson(String str) =>
    HolidayCalendarModel.fromJson(json.decode(str));

String holidayCalendarModelToJson(HolidayCalendarModel data) =>
    json.encode(data.toJson());

class HolidayCalendarModel {
  final String status;
  final String message;
  final HolidayData data;

  HolidayCalendarModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory HolidayCalendarModel.fromJson(Map<String, dynamic> json) =>
      HolidayCalendarModel(
        status: json["status"],
        message: json["message"],
        data: HolidayData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
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

  factory HolidayData.fromJson(Map<String, dynamic> json) => HolidayData(
    year: json["year"],
    totalHolidays: json["total_holidays"],
    holidays:
    List<Holiday>.from(json["holidays"].map((x) => Holiday.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "year": year,
    "total_holidays": totalHolidays,
    "holidays": List<dynamic>.from(holidays.map((x) => x.toJson())),
  };
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

  factory Holiday.fromJson(Map<String, dynamic> json) => Holiday(
    date: json["date"],
    day: json["day"],
    festival: json["festival"],
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "day": day,
    "festival": festival,
  };
}
