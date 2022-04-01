import 'dart:convert';

import 'package:dawam/models/entry.dart';
import 'package:dawam/models/month.dart';

class CurrentMonth {
  int workingSecondsTody;
  Entry? lastEntryTody;
  Month month;
  CurrentMonth({
    required this.workingSecondsTody,
    required this.lastEntryTody,
    required this.month,
  });




  Map<String, dynamic> toMap() {
    return {
      'workingSecondsTody': workingSecondsTody,
      'lastEntryTody': lastEntryTody?.toMap(),
      'month': month.toMap(),
    };
  }

  factory CurrentMonth.fromMap(Map<String, dynamic> map) {
    return CurrentMonth(
      workingSecondsTody: map['workingSecondsTody']?.toInt() ?? 0,
      lastEntryTody: map['lastEntryTody'] != null ? Entry.fromMap(map['lastEntryTody']) : null,
      month: Month.fromMap(map['month']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrentMonth.fromJson(String source) => CurrentMonth.fromMap(json.decode(source));
}
