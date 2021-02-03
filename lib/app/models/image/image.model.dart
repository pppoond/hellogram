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
    this.imgDescript,
    this.imgAddress,
  });

  String imgId;
  dynamic imgDescript;
  String imgAddress;

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        imgId: json["img_id"],
        imgDescript: json["img_descript"],
        imgAddress: json["img_address"],
      );

  Map<String, dynamic> toJson() => {
        "img_id": imgId,
        "img_descript": imgDescript,
        "img_address": imgAddress,
      };
}
