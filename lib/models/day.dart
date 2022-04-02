import 'dart:convert';

import 'package:dawam/models/entry.dart';
import 'package:dawam/utilities/app_consts.dart';

class Day {
  int id;
  String date;
  int workingSeconds;
  List<Entry> entries;
  Day({
    required this.id,
    required this.date,
    required this.workingSeconds,
    required this.entries,
  });

  String getDate() {
    return AppConsts().dayNameFormat.format(DateTime.parse(date)) +
        AppConsts().ddMMFormat.format(DateTime.parse(date));
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'workingSeconds': workingSeconds,
      'entries': entries.map((x) => x.toMap()).toList(),
    };
  }

  factory Day.fromMap(Map<String, dynamic> map) {
    return Day(
      id: map['id']?.toInt() ?? 0,
      date: map['date'] ?? '',
      workingSeconds: map['workingSeconds']?.toInt() ?? 0,
      entries: List<Entry>.from(
          map['entries']?.map((x) => Entry.fromMap(x)) ?? const []),
    );
  }

  String toJson() => json.encode(toMap());

  factory Day.fromJson(String source) => Day.fromMap(json.decode(source));
}
