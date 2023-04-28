// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.id,
    required this.user,
    required this.password,
  });

  dynamic id;
  dynamic user;
  dynamic password;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    id: json["id"],
    user: json["user"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user,
    "password": password,
  };
}
