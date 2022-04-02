import 'dart:convert';

import 'package:dawam/utilities/app_consts.dart';

class Entry {
  int id;
  String date;
  bool isInput;
  Entry({
    required this.id,
    required this.date,
    required this.isInput,
  });
  
  String getTime() {
    return AppConsts().timeFormat.format(DateTime.parse(date)) +
        AppConsts().h12Format.format(DateTime.parse(date));
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'isInput': isInput,
    };
  }

  factory Entry.fromMap(Map<String, dynamic> map) {
    return Entry(
      id: map['id']?.toInt() ?? 0,
      date: map['date'] ?? '',
      isInput: map['isInput'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Entry.fromJson(String source) => Entry.fromMap(json.decode(source));
}
