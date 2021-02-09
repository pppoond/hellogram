// To parse this JSON data, do
//
//     final imageModel = imageModelFromJson(jsonString);

import 'dart:convert';

List<ImageModel> imageModelFromJson(String str) =>
    List<ImageModel>.from(json.decode(str).map((x) => ImageModel.fromJson(x)));

String imageModelToJson(List<ImageModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ImageModel {
  ImageModel({
    this.imgId,
    this.userId,
    this.postId,
    this.imgDescript,
    this.imgAddress,
    this.timeReg,
  });

  String imgId;
  String userId;
  String postId;
  dynamic imgDescript;
  String imgAddress;
  DateTime timeReg;

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        imgId: json["img_id"],
        userId: json["user_id"],
        postId: json["post_id"],
        imgDescript: json["img_descript"],
        imgAddress: json["img_address"],
        timeReg: DateTime.parse(json["time_reg"]),
      );

  Map<String, dynamic> toJson() => {
        "img_id": imgId,
        "user_id": userId,
        "post_id": postId,
        "img_descript": imgDescript,
        "img_address": imgAddress,
        "time_reg": timeReg.toIso8601String(),
      };
}
