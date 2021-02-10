import 'dart:async';
import 'dart:convert';

import 'package:hellogram/app/models/list/list.model.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hellogram/app/api/api.dart';
import 'package:hellogram/app/screens/login/login_page.dart';
import 'package:http/http.dart' as http;

class ListPage extends StatefulWidget {
  final ListModel listModel;

  ListPage(this.listModel);
  @override
  _ListPageState createState() => _ListPageState(this.listModel);
}

class _ListPageState extends State<ListPage> {
  final globalKey = GlobalKey<ScaffoldState>();
  final ListModel listModel;
  _ListPageState(this.listModel);
  String statusSuccess;

  List data;

  Future<String> getData() async {
    var response = await http.get(Uri.encodeFull(Api.getUrl),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = listModelFromJson(response.body);
      //data = json.decode(response.body);
      //debugPrint(data.toString());
      //debugPrint("----------------");
      //debugPrint(data[1]['id'].toString());
    });

    return "Success!";
  }

  void _checkLogin() {}

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Add Your Code here.
      this.getData();
      debugPrint("hellllllloooooooooooooooo");
      print("constuctor print test ${listModel.getUsername}");
      statusSuccess = listModel.getUsername;
      if (statusSuccess != null) {
        _snackBarSuccess();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const iconColors = Colors.black54;
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          'Hellogram',
          style: TextStyle(
              color: Colors.black87, fontFamily: 'Billabong', fontSize: 30.0),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.inbox,
              color: iconColors,
            ),
            tooltip: 'Next page',
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: iconColors,
            ),
            tooltip: 'Next page',
            onPressed: () {},
          ),
          Container(
            margin: EdgeInsets.only(right: 12.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile.jpg'),
            ),
          )
        ],
      ),
      body: ListView.builder(
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
                              backgroundImage:
                                  NetworkImage(data[index].profile),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              data[index].username,
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
                          color: iconColors,
                        ),
                        tooltip: 'Next page',
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Image.network(data[index].img),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(
                              Icons.favorite,
                              color: iconColors,
                            ),
                            tooltip: 'Next page',
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.comment_rounded,
                              color: iconColors,
                            ),
                            tooltip: 'Next page',
                            onPressed: () {},
                          ),
                          RotationTransition(
                            turns: new AlwaysStoppedAnimation(0 / 360),
                            child: IconButton(
                              icon: const Icon(
                                Icons.send,
                                color: iconColors,
                              ),
                              tooltip: 'Next page',
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.save_alt,
                          color: iconColors,
                        ),
                        tooltip: 'Next page',
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          '${data[index].username}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ' ',
                        ),
                        Text(data[index].descript),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                ],
              ),
            );
          }),
      bottomNavigationBar: Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.home_filled,
              color: iconColors,
            ),
            tooltip: 'Next page',
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.search,
              color: iconColors,
            ),
            tooltip: 'Next page',
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.add,
              color: iconColors,
            ),
            tooltip: 'Next page',
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.shopping_bag,
              color: iconColors,
            ),
            tooltip: 'Next page',
            onPressed: () {},
          ),
          IconButton(
              icon: const Icon(
                Icons.more_horiz,
                color: iconColors,
              ),
              tooltip: 'Next page',
              onPressed: () {
                // Navigator.of(context).push(new PageRouteBuilder(
                //     opaque: true,
                //     transitionDuration: const Duration(seconds: 1),
                //     pageBuilder: (BuildContext context, _, __) {
                //       return new LoginPage();
                //     },
                //     transitionsBuilder:
                //         (_, Animation<double> animation, __, Widget child) {
                //       return new SlideTransition(
                //         child: child,
                //         position: new Tween<Offset>(
                //           begin: const Offset(0, 0),
                //           end: Offset.zero,
                //         ).animate(animation),
                //       );
                //     }));
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return LoginPage();
                // }));
                // Navigator.push(
                //     context,
                //     EnterExitRoute(
                //         exitPage: ListPage(), enterPage: LoginPage()));
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  return LoginPage();
                }));
              }),
        ],
      )),
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

class EnterExitRoute extends PageRouteBuilder {
  static Widget enterPage;
  static Widget exitPage;
  EnterExitRoute({exitPage, enterPage})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              enterPage,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              Stack(
            children: <Widget>[
              SlideTransition(
                position: new Tween<Offset>(
                  begin: const Offset(0.0, 0.0),
                  end: const Offset(-1.0, 0.0),
                ).animate(animation),
                child: exitPage,
              ),
              SlideTransition(
                position: new Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: enterPage,
              )
            ],
          ),
        );
}
