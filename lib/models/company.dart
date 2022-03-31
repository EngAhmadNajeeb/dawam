import 'dart:convert';

class Company {
  int id;
  String companyDomainName;
  String email;
  String name;
  String longitude;
  String latitude;
  int destance;
  Company({
    required this.id,
    required this.companyDomainName,
    required this.email,
    required this.name,
    required this.longitude,
    required this.latitude,
    required this.destance,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'companyDomainName': companyDomainName,
      'email': email,
      'name': name,
      'longitude': longitude,
      'latitude': latitude,
      'destance': destance,
    };
  }

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      id: map['id']?.toInt() ?? 0,
      companyDomainName: map['companyDomainName'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      longitude: map['longitude'] ?? '',
      latitude: map['latitude'] ?? '',
      destance: map['destance']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Company.fromJson(String source) => Company.fromMap(json.decode(source));
}
