import 'dart:convert';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String token;
  final String password;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'token': token,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      token: map['token'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
