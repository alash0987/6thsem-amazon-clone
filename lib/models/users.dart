import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String type;
  final String token;
  final String address;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.type,
    required this.token,
    this.address = '',
  });

  //  Create json serialization
  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "password": password,
        "type": type,
        "token": token,
        "address": address,
      };
  // Create from Map serialization
  factory User.fromMap(Map<String, dynamic> map) => User(
        id: map["_id"],
        name: map["name"],
        email: map["email"],
        password: map["password"],
        type: map["type"],
        token: map["token"],
        address: map["address"],
      );

  String toJson() => json.encode(toMap());
  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
