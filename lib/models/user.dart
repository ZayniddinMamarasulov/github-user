import 'dart:convert';

class User {
  String? login;
  int? id;

  User({required this.login, required this.id});

  factory User.fromJson(Map<String, dynamic> jsonData) {
    String login = jsonData['login'] ?? "";
    int id = jsonData['id'] ?? 0;

    return User(login: login, id: id);
  }
}
