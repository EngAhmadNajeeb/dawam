import 'dart:convert';

import 'package:dawam/models/company.dart';

class User {
  int id;
  String username;
  String email;
  Company company;
  String firstNameAr;
  String firstNameEn;
  String lastNameAr;
  String lastNameEn;
  String fullName;
  String role;
  bool accountNonLocked;
  bool enabled;
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.company,
    required this.firstNameAr,
    required this.firstNameEn,
    required this.lastNameAr,
    required this.lastNameEn,
    required this.fullName,
    required this.role,
    required this.accountNonLocked,
    required this.enabled,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'company': company.toMap(),
      'firstNameAr': firstNameAr,
      'firstNameEn': firstNameEn,
      'lastNameAr': lastNameAr,
      'lastNameEn': lastNameEn,
      'fullName': fullName,
      'role': role,
      'accountNonLocked': accountNonLocked,
      'enabled': enabled,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt() ?? 0,
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      company: Company.fromMap(map['company']),
      firstNameAr: map['firstNameAr'] ?? '',
      firstNameEn: map['firstNameEn'] ?? '',
      lastNameAr: map['lastNameAr'] ?? '',
      lastNameEn: map['lastNameEn'] ?? '',
      fullName: map['fullName'] ?? '',
      role: map['role'] ?? '',
      accountNonLocked: map['accountNonLocked'] ?? false,
      enabled: map['enabled'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
