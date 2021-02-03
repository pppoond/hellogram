// To parse this JSON data, do
//
//     final listModel = listModelFromJson(jsonString);

import 'dart:convert';

List<UserModel> userModelFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  UserModel({
    this.user_id,
    this.user_name,
    this.user_username,
    this.user_password,
  });

  int user_id;
  String user_name;
  String user_username;
  String user_password;

  int get getUserid => user_id;

  set setUserid(int value) => user_id = value;

  String get getUsername => user_name;

  set setUsername(String value) => user_name = value;

  String get getUserusername => user_username;

  set setUserusername(String value) => user_username = value;

  String get getUserpassword => user_password;

  set setUserpassword(String value) => user_password = value;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        user_id: json["user_id"],
        user_password: json["user_name"],
        user_name: json["user_username"],
        user_username: json["user_password"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": user_id,
        "user_name": user_name,
        "user_username": user_username,
        "user_password": user_password,
      };
}
