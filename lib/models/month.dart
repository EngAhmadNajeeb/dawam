import 'dart:convert';

import 'package:dawam/models/day.dart';
import 'package:dawam/utilities/app_consts.dart';

class Month {
  int id;
  String date;
  int requiredWorkingHours;
  int flowWorkingSeconds;
  int workingSeconds;
  List<Day> days;
  bool currentMonth;
  Month({
    required this.id,
    required this.date,
    required this.requiredWorkingHours,
    required this.flowWorkingSeconds,
    required this.workingSeconds,
    required this.days,
    required this.currentMonth,
  });
  String getMonthName() {
    return AppConsts().monthNameFormat.format(DateTime.parse(date));
  }

  String getYear() {
    return AppConsts.yearFormat.format(DateTime.parse(date));
  }

  String getDate() {
    return AppConsts().monthNameFormat.format(DateTime.parse(date)) +
        AppConsts.mmyyyyFormat.format(DateTime.parse(date));
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'requiredWorkingHours': requiredWorkingHours,
      'flowWorkingSeconds': flowWorkingSeconds,
      'workingSeconds': workingSeconds,
      'days': days.map((x) => x.toMap()).toList(),
      'currentMonth': currentMonth,
    };
  }

  factory Month.fromMap(Map<String, dynamic> map) {
    return Month(
      id: map['id']?.toInt() ?? 0,
      date: map['date'] ?? '',
      requiredWorkingHours: map['requiredWorkingHours']?.toInt() ?? 0,
      flowWorkingSeconds: map['flowWorkingSeconds']?.toInt() ?? 0,
      workingSeconds: map['workingSeconds']?.toInt() ?? 0,
      days: List<Day>.from(map['days']?.map((x) => Day.fromMap(x)) ?? const []),
      currentMonth: map['currentMonth'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Month.fromJson(String source) => Month.fromMap(json.decode(source));
}
