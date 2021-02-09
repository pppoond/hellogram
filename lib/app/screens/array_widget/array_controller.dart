import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hellogram/app/api/api.dart';
import 'package:hellogram/app/models/post/post.model.dart';
import 'package:http/http.dart' as http;

class ArrayDaoController {
  Future<List> getImgByPostID(String postId) async {
    var respone2 = await http.get(Api.getImageUrl + "$postId");
    List<String> _imgArray = new List();

    //var results2 = imageModelFromJson(respone2.body);
    var results2 = jsonDecode(respone2.body);
    if (results2 != null) {
      print("Images Length = ${results2}");

      for (var i_img in results2) {
        String imgId = i_img['img_id'];
        String imgAddress = i_img['img_address'];
        print("Img ID = $imgId : Img Address = $imgAddress");

        _imgArray.add(imgAddress);
      }
    } else {
      print("Images Length = is null");
    }
    return _imgArray;
  }

  Future<List> getUserById(String userId) async {
    var respone3 = await http.get(Api.getUserUrl + "$userId");
    List _userArray = new List();

    //var results2 = imageModelFromJson(respone2.body);
    var results3 = jsonDecode(respone3.body);
    if (results3 != null) {
      print("User Length = ${results3}");

      for (var i_user in results3) {
        String userId = i_user['user_id'];
        String name = i_user['user_name'];
        String username = i_user['username'];
        print("User ID = $userId : User Name = $name : Username = $username");

        _userArray.add(i_user);
      }
      print("Check before return ==>> $_userArray");
    } else {
      print("User Length = is null");
    }
    return _userArray;
  }

  Future<List> getProfileImgById(String userId) async {
    var respone3 = await http.get(Api.getProfileImgUrl + "$userId");
    List _profileArray = new List();

    //var results2 = imageModelFromJson(respone2.body);
    var results3 = jsonDecode(respone3.body);
    if (results3 != null) {
      print("User Length = ${results3}");

      for (var i_user in results3) {
        String userId = i_user['user_id'];
        String name = i_user['user_name'];
        String username = i_user['username'];
        print("User ID = $userId : User Name = $name : Username = $username");

        _profileArray.add(i_user);
      }
      print("Check before return ==>> $_profileArray");
    } else {
      print("User Length = is null");
    }
    return _profileArray;
  }

  Future<String> getCheckLiked(String postId, String userId) async {
    var respone3 =
        await http.get(Api.onLikeCheckUrl + "post_id=$postId&user_id=$userId");
    String _likedStr;

    //var results2 = imageModelFromJson(respone2.body);
    var results3 = jsonDecode(respone3.body);
    if (results3 != null) {
      print("Like Check = ${results3}");

      // for (var liked in results3) {
      //   // String userId = i_user['user_id'];
      //   // String name = i_user['user_name'];
      //   // String username = i_user['username'];
      //   //print("User ID = $userId : User Name = $name : Username = $username");

      //   _likedArray.add(liked);
      // }
      _likedStr = results3;
      print("Check Like return ==>> $_likedStr");
    } else {
      print("Check Like Length = is null");
    }
    return _likedStr;
  }

  Future<String> onClickLike(String postId, String userSessionId) async {
    var respone3 = await http
        .get(Api.onLikeUrl + "post_id=$postId&user_id=$userSessionId");
    String _likedStr;
    var results3 = jsonDecode(respone3.body);
    if (results3 != null) {
      print("Like Check = ${results3}");
      _likedStr = results3;
      print("Check Like return ==>> $_likedStr");
    } else {
      print("Check Like Length = is null");
    }
    return _likedStr;
  }

  Future<String> countLike(String postId) async {
    var respone3 = await http.get(Api.countLikeUrl + "$postId");
    String countStr;
    var results3 = jsonDecode(respone3.body);
    if (results3 != null) {
      print("Total Like = ${results3}");
      countStr = "$results3";
      print("Total Like return ==>> $countStr");
    } else {
      print("Total Like Length = is null");
    }
    return countStr;
  }
}
