import 'dart:convert';

class ApiJsonResponse {
  String? timestamp;
  int? status;
  String? error;
  String? message;
  dynamic data;

  ApiJsonResponse({
    this.timestamp,
    this.status,
    this.error,
    this.message,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp,
      'status': status,
      'error': error,
      'message': message,
      'data': data,
    };
  }

  factory ApiJsonResponse.fromMap(Map<String, dynamic> map) {
    return ApiJsonResponse(
      timestamp: map['timestamp'],
      status: map['status']?.toInt(),
      error: map['error'],
      message: map['message'],
      data: map['data'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiJsonResponse.fromJson(String source) =>
      ApiJsonResponse.fromMap(json.decode(source));
}
