// To parse this JSON data, do
//
//     final listModel = listModelFromJson(jsonString);

import 'dart:convert';

List<ListModel> listModelFromJson(String str) =>
    List<ListModel>.from(json.decode(str).map((x) => ListModel.fromJson(x)));

String listModelToJson(List<ListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListModel {
  ListModel({
    this.id,
    this.username,
    this.profile,
    this.img,
    this.descript,
  });

  int id;
  String username;
  String profile;
  String img;
  String descript;

  int get getId => id;

  set setId(int id) => this.id = id;

  String get getUsername => username;

  set setUsername(String username) => this.username = username;

  String get getProfile => profile;

  set setProfile(String profile) => this.profile = profile;

  String get getImg => img;

  set setImg(String img) => this.img = img;

  String get getDescript => descript;

  set setDescript(String descript) => this.descript = descript;

  factory ListModel.fromJson(Map<String, dynamic> json) => ListModel(
        id: json["id"],
        username: json["username"],
        profile: json["profile"],
        img: json["img"],
        descript: json["descript"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "profile": profile,
        "img": img,
        "descript": descript,
      };
}
