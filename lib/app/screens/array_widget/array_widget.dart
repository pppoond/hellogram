import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:hellogram/app/models/image/image.model.dart';
import 'package:hellogram/app/models/post/post.model.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:hellogram/app/api/api.dart';
import 'package:hellogram/app/screens/array_widget/array_controller.dart';
import 'package:hellogram/app/screens/login/login_page.dart';
import 'package:hellogram/app/screens/register/register_page.dart';
import 'package:hellogram/app/utils/check_logged.dart';
import 'package:hellogram/app/utils/shared_prefs.dart';

import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'list_widget.dart';

class ArrayWidget extends StatefulWidget {
  @override
  _ArrayWidgetState createState() => _ArrayWidgetState();
}

class _ArrayWidgetState extends State<ArrayWidget> {
  final globalKey = GlobalKey<ScaffoldState>();
  String titleBar = "Hellogram";
  static dynamic _like;

  EasyRefreshController _easyRefController;

  ArrayDaoController arrayController = new ArrayDaoController();

//recieve value userId from login.
  static var userIdSession;
  static var mainProfileImg;

  String statusSuccess;
  List<PostModel> data;
  List<Widget> _widgetArray = new List();

  static var iconColors = (Colors.grey);
  //static dynamic _like = false;
  // List img_data;

  Future getData() async {
    var response =
        await http.get(Api.getPostUrl, headers: {"Accept": "application/json"});

    // this.setState(() {
    //   data = postModelFromJson(response.body);
    // });
    var results = postModelFromJson(response.body);
    print('Length = ${results.length}');
    for (var i in results) {
      List<String> _listString = new List();
      //List<String> _userList = new List();
      String userId = i.userId;
      String postId = i.postId;
      String name;
      String username;
      String postDescript = i.postDescript;
      String profileImg;
      String timeAgo;

      DateTime timeReg = i.timeReg;
      timeAgo = timeago.format(timeReg);

      print("Time Ago $timeAgo");

      List getUser = await arrayController.getUserById(userId);
      if (getUser != null) {
        print("Future List User = not null");
        for (var item in getUser) {
          print("User Object = ${item}");
          name = item['user_name'];
          username = item['username'];

          //_userList.addAll(item['user_name']);
        }
        //print("List String in Get User ==>> ${_userList}");
      } else {
        print("Future List User = is null");
      }

      List getImg = await arrayController.getImgByPostID(postId);
      if (getImg != null) {
        print("Future List Image = not null");
        for (var item in getImg) {
          print("Img Address = $item");

          _listString.add("$item");
        }
        print("List String in Get Image ==>> ${_listString}");
      } else {
        print("Future List Image = is null");
      }

      List getProfileImg = await arrayController.getProfileImgById(userId);
      if (getProfileImg != null) {
        for (var item in getProfileImg) {
          profileImg = item['pro_img_addr'];
        }
      }

      String checkLike =
          await arrayController.getCheckLiked(postId, userIdSession);

      print(
          "Like check ==>> Post ID = $postId : UserSession ID = $userIdSession");

      String totalLike = await arrayController.countLike(postId);

      print("Total Like in this post ==>> $totalLike");

      _widgetArray.add(ListWidget(
        userIdSession: userIdSession,
        userId: userId,
        postId: postId,
        name: name,
        username: username,
        postDescript: postDescript,
        listString: _listString,
        profileImg: profileImg,
        checkLike: checkLike,
        totalLike: totalLike,
        timeAgo: timeAgo,
      ));
    }
    if (_widgetArray == null) {
      print('Widget Array Null');
    } else {
      print("Widget Array Length = ${_widgetArray.length}");
    }

    setState(() {});
  }

  void onPressLike() {
    setState(() {});
    //_snackBarSuccess();
  }

  // void _checkLogin() async {
  //   String checkLike = await arrayController.getCheckLiked("5", "1");
  //   print("Home List Check Liked ==>> $checkLike");
  // }

  void _onLoadPage() async {
    SharedPrefs prefs = new SharedPrefs();
    SharedPreferences pref = await prefs.prefs;
    userIdSession = pref.getString("userIdPref");
    print("UserIdSession ==>> : $userIdSession");
    var result = await arrayController.getProfileImgById(userIdSession);
    if (result != null) {
      print("UserMain result check ==>> : is not null ==>> : $result");
      for (var item in result) {
        setState(() {
          String profileImg = item['pro_img_addr'];
          mainProfileImg = profileImg;
        });
      }
    } else {
      print("UserMain result check ==>> : is null");
    }
    print("UserMain Profile ==>> : $mainProfileImg");
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Add Your Code here.
      _onLoadPage();
      getData();
    });
    _easyRefController = EasyRefreshController();
    // _checkLogin();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ListView _listView = ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(0.0),
        itemCount: _widgetArray == null ? 0 : _widgetArray.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black12,
              ),
            ),
            margin: EdgeInsets.all(2.0),
            padding: EdgeInsets.only(bottom: 5.0),
            child: _widgetArray[index],
          );
        });

    AppBar _appBar = AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        '$titleBar',
        style: TextStyle(fontFamily: 'Billabong', fontSize: 30.0),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.logout,
          ),
          color: iconColors,
          tooltip: 'Next page',
          onPressed: () async {
            SharedPrefs prefs = new SharedPrefs();
            SharedPreferences pref = await prefs.prefs;
            pref.remove("userIdPref");
            Navigator.push(context, CupertinoPageRoute(builder: (context) {
              return LoginPage();
            }));
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.notifications,
          ),
          color: iconColors,
          tooltip: 'Next page',
          onPressed: () {
            //notify
            setState(() {
              titleBar = "Change";
              print("press Change");
            });
          },
        ),
        Container(
          margin: EdgeInsets.only(right: 12.0),
          child: CircleAvatar(
            backgroundImage: (mainProfileImg != null)
                ? NetworkImage(Api.imageUrl + '$mainProfileImg')
                : AssetImage('assets/images/profile.jpg'),
          ),
        )
      ],
    );

    return Scaffold(
        key: globalKey,
        appBar: _appBar,
        body: RefreshIndicator(
          onRefresh: () async {
            _widgetArray.clear();
            await getData();
            setState(() {});
            return;
          },
          child: _listView,
        ));
  }
//   NotificationListener<ScrollUpdateNotification>(
//   child: ListView(
//     children: ...
//   ),
//   onNotification: (notification) {
//     //How many pixels scrolled from pervious frame
//     print(notification.scrollDelta);

//     //List scroll position
//     print(notification.metrics.pixels);
//   },
// ),

  Future _refreshOnScroll() {
    _widgetArray.clear();
    getData();
    setState(() {});
    return null;
  }

  void _snackBarSuccess() {
    final snackBar = SnackBar(
        backgroundColor: Colors.blueAccent,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Logged'),
          ],
        ));

    // Find the Scaffold in the widget tree and use
    // it to show a SnackBar.
    globalKey.currentState.showSnackBar(snackBar);
  }
}
