import 'dart:convert';

import 'package:dawam/models/user.dart';

class AuthData {
  String token;
  User user;
  AuthData({
    required this.token,
    required this.user,
  });

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'user': user.toMap(),
    };
  }

  factory AuthData.fromMap(Map<String, dynamic> map) {
    return AuthData(
      token: map['token'] ?? '',
      user: User.fromMap(map['user']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthData.fromJson(String source) => AuthData.fromMap(json.decode(source));
}
