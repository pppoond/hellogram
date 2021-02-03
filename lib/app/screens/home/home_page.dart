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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final globalKey = GlobalKey<ScaffoldState>();
  String statusSuccess;
  List<PostModel> data;
  // List img_data;

  Future<String> getData() async {
    /*สิ่งที่จะทำพรุ่งนี้ for in เข้า ใน resonse หรือ array ซักตัว อะไรก็ช่าง ลืมม แต่เขียนไว้กันลืม 
    หลังจากนั่น ก็ for เอาค่า ไป fetch api ของ user กับ ภาพ  มาเก็บไว้ใน array ด้วยหมทือนกัน */
    var response =
        await http.get(Api.getPostUrl, headers: {"Accept": "application/json"});

    this.setState(() {
      data = postModelFromJson(response.body);
      //debugPrint(response.body.toString());
      debugPrint("${data[0].postId}");
      //data = json.decode(response.body);
      //debugPrint(data.toString());
      //debugPrint("----------------");
      //debugPrint(data[1]['id'].toString());
    });

    return "Success!";
  }

  // Future<List> getImage(String post_id) async {
  //   var response = await http.get(Api.getImageUrl + "$post_id",
  //       headers: {"Accept": "application/json"});

  //   this.setState(() {
  //     img_data = imageModelFromJson(response.body);
  //     //debugPrint(response.body.toString());
  //     debugPrint(img_data.toString());
  //     //data = json.decode(response.body);
  //     //debugPrint(data.toString());
  //     //debugPrint("----------------");
  //     //debugPrint(data[1]['id'].toString());
  //   });
  //   // return Image.network(
  //   //     "http://192.168.0.102/hellogram/" + img_data[0].imgAddress.toString());
  //   return img_data;
  // }

  // Future<String> _imageWidget(postId) async {
  //   print("Tab Image");
  //   // http://202.28.34.250/IonicMovie/api/Movie/tt1979376
  //   String ws = Api.getImageUrl + postId;
  //   var response = await http
  //       .get(ws, headers: {HttpHeaders.acceptHeader: 'application/json'});

  //   List<String> img_data = jsonDecode(response.body);

  //   print(img_data[0][4]);

  //   return "img_data";
  // }

  // Widget _imgWidget(String post_id) {
  //   var img = _imageWidget(post_id);
  //   //print("immmmmmmmmmmmmmmmmmmmmmmmmm ${img_data[0]['img_address']}");
  //   return Image.network("http://192.168.0.102/hellogram/uploads/post2.jpg");
  // }

  void _checkLogin() {}

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Add Your Code here.
      this.getData();
      debugPrint("hellllllloooooooooooooooo");

      // if (listModel.getUsername != null) {
      //   print("constuctor print test ${listModel.getUsername}");
      // }

      // statusSuccess = listModel.getUsername;
      // if (statusSuccess != null) {
      //   _snackBarSuccess();
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    dynamic _like = false;
    const iconColors = (Colors.grey);
    ListView _listView = ListView.builder(
        padding: const EdgeInsets.all(0.0),
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black12,
              ),
            ),
            margin: EdgeInsets.all(2.0),
            padding: EdgeInsets.only(bottom: 5.0),
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
                              // backgroundImage: NetworkImage(data[index].profile),
                              ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "${data[index].userId}",
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
                          '${data[index].userId}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ' ',
                        ),
                        Text(data[index].postDescript),
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
                                color: Colors.grey[400],
                                fontWeight: FontWeight.bold),
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
