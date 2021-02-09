import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:hellogram/app/models/image/image.model.dart';
import 'package:hellogram/app/models/post/post.model.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hellogram/app/api/api.dart';
import 'package:hellogram/app/screens/login/login_page.dart';
import 'package:hellogram/app/screens/register/register_page.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final globalKey = GlobalKey<ScaffoldState>();
  String statusSuccess;
  List<PostModel> data;
  List<Widget> _widgetArray = new List();

  static const iconColors = (Colors.grey);
  static dynamic _like = false;
  // List img_data;

  Future getData() async {
    /*สิ่งที่จะทำพรุ่งนี้ for in เข้า ใน resonse หรือ array ซักตัว อะไรก็ช่าง ลืมม แต่เขียนไว้กันลืม 
    หลังจากนั่น ก็ for เอาค่า ไป fetch api ของ user กับ ภาพ  มาเก็บไว้ใน array ด้วยหมทือนกัน */
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
      String profile_img;

      List getUser = await getUserById(userId);
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

      List getImg = await getImgByPostID(postId);
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

      List getProfileImg = await getProfileImgById(userId);
      if (getProfileImg != null) {
        for (var item in getProfileImg) {
          profile_img = item['pro_img_addr'];
        }
      }

      print("User ID = $userId");

      _widgetArray.add(_widgetItem(userId, postId, name, username, postDescript,
          _listString, profile_img));
    }
    if (_widgetArray == null) {
      print('Widget Array Null');
    } else {
      print("Widget Array Length = ${_widgetArray.length}");
    }

    setState(() {});
  }

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

  Widget _widgetItem(String userId, String postId, String name, String username,
      String postDescript, List<String> _listString, String profile_img) {
    print("List String ==>> Widget ${_listString.length}");
    //print("List User in Widget ==>> Widget ${_userList}");
    // String name;
    // String username;
    if (_listString != null) {
      for (var img in _listString) {
        print("Image Widget is test $img");
      }
    }
    // List<String> _listString = ["1", "2", "3"];
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 2.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 5.0),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: (profile_img != null)
                          ? NetworkImage(Api.imageUrl + "$profile_img")
                          : NetworkImage(
                              "https://lh3.googleusercontent.com/proxy/R391DDOdDiU4o7kficb_uqlJYtGJbERVfTXDjKPqCt0vGxzMr2oPmvghsAa8KHCVxS9gMIhV4kDPXMVd1q5TWmGyDHRio-jHAtVkhCidRW6_4TYCYbo3MA"),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      "${username}",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.more_horiz,
                ),
                color: iconColors,
                tooltip: 'Next page',
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(
            height: 2.0,
          ),

          // Container(
          //   child: Image.network(
          //       Api.imageUrl + "${data[index].postImgs.imgAddress}"),
          // ),

          (_listString.length != 0)
              ? Container(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.width,
                    ),
                    items: _listString
                        .map((item) => Container(
                              child: Center(
                                child: Image.network(
                                  Api.imageUrl + item.toString(),
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              //color: Colors.green,
                            ))
                        .toList(),
                  ),
                )
              : Container(),
          // Container(
          //     // child ListView
          //     height: 300,
          //     child: new ListView.builder(
          //       scrollDirection: Axis.horizontal,
          //       itemCount: _listString == null ? 0 : _listString.length,
          //       itemBuilder: (BuildContext context, index2) =>
          //           Image.network(Api.imageUrl + "${_listString[index2]}"),
          //     ),
          //   )

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.favorite,
                    ),
                    color: (_like == true) ? iconColors : Colors.red[400],
                    tooltip: 'Next page',
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.comment_rounded,
                    ),
                    color: iconColors,
                    tooltip: 'Next page',
                    onPressed: () {},
                  ),
                  RotationTransition(
                    turns: new AlwaysStoppedAnimation(0 / 360),
                    child: IconButton(
                      icon: const Icon(
                        Icons.send,
                      ),
                      color: iconColors,
                      tooltip: 'Next page',
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(
                  Icons.save_alt,
                ),
                color: iconColors,
                tooltip: 'Next page',
                onPressed: () {},
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 12.0, right: 12.0),
            child: Column(children: <Widget>[
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      // Respond to button press
                      print('tab text');
                    },
                    child: Text(
                      "ถูกใจทั้งหมด 258 คน",
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: <Widget>[
                  Text(
                    "${username}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(" "),
                  Text("${postDescript}")
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      // Respond to button press
                      print('tab text');
                    },
                    child: Text(
                      "ดูความคิดเห็นทั้งหมด",
                      style: TextStyle(
                          color: Colors.grey[400], fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ]),
          ),
          SizedBox(
            height: 5.0,
          ),
        ],
      ),
    );
  }

  void _checkLogin() {}

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Add Your Code here.
      getData();
    });
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
        'Hellogram',
        style: TextStyle(fontFamily: 'Billabong', fontSize: 30.0),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.inbox,
          ),
          color: iconColors,
          tooltip: 'Next page',
          onPressed: () {
            Navigator.push(context, CupertinoPageRoute(builder: (context) {
              return LoginPage(null);
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
            Navigator.push(context, CupertinoPageRoute(builder: (context) {
              return LoginPage(null);
            }));
          },
        ),
        Container(
          margin: EdgeInsets.only(right: 12.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/profile.jpg'),
          ),
        )
      ],
    );
    return Scaffold(
      key: globalKey,
      appBar: _appBar,
      body: _listView,
    );
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
