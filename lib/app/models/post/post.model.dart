// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

List<PostModel> postModelFromJson(String str) =>
    List<PostModel>.from(json.decode(str).map((x) => PostModel.fromJson(x)));

String postModelToJson(List<PostModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostModel {
  PostModel({
    this.postId,
    this.userId,
    this.postTitle,
    this.postDescript,
    this.timeReg,
  });

  String postId;
  String userId;
  dynamic postTitle;
  String postDescript;
  DateTime timeReg;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        postId: json["post_id"],
        userId: json["user_id"],
        postTitle: json["post_title"],
        postDescript: json["post_descript"],
        timeReg: DateTime.parse(json["time_reg"]),
      );

  Map<String, dynamic> toJson() => {
        "post_id": postId,
        "user_id": userId,
        "post_title": postTitle,
        "post_descript": postDescript,
        "time_reg": timeReg.toIso8601String(),
      };
}
