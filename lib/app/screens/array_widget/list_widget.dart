import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hellogram/app/api/api.dart';

import 'array_controller.dart';

class ListWidget extends StatefulWidget {
  final String userIdSession;
  final String userId;
  final String postId;
  final String name;
  final String username;
  final String postDescript;
  final List<String> listString;
  final String profileImg;
  String checkLike;
  String totalLike;
  String timeAgo;
  ListWidget({
    Key key,
    this.userIdSession,
    this.userId,
    this.postId,
    this.name,
    this.username,
    this.postDescript,
    this.listString,
    this.profileImg,
    this.checkLike,
    this.totalLike,
    this.timeAgo,
  }) : super(key: key);

  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  var iconColors = Colors.grey;
  var _like;
  ArrayDaoController arrayDaoController = new ArrayDaoController();
  @override
  void initState() {
    // if (_like != null) {
    //   _like = true;
    // } else {
    //   _like = false;
    // // }
    // print("Post ID : $postId");
    print("List String ==>> Widget ${widget.listString.length}");
    //print("List User in Widget ==>> Widget ${_userList}");
    // String name;
    // String username;
    if (widget.listString != null) {
      for (var img in widget.listString) {
        print("Image Widget is test $img");
      }
    }
    if (widget.checkLike == "liked") {
      _like = true;
    } else {
      _like = false;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      backgroundImage: (widget.profileImg != null)
                          ? NetworkImage(Api.imageUrl + "${widget.profileImg}")
                          : NetworkImage(
                              "https://lh3.googleusercontent.com/proxy/R391DDOdDiU4o7kficb_uqlJYtGJbERVfTXDjKPqCt0vGxzMr2oPmvghsAa8KHCVxS9gMIhV4kDPXMVd1q5TWmGyDHRio-jHAtVkhCidRW6_4TYCYbo3MA"),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "${widget.username}",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 3.0,
                            ),
                            Container(
                              child: Text(
                                "${widget.timeAgo}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ]),
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

          (widget.listString.length != 0)
              ? KeepAlive(
                  child: Container(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.width,
                    ),
                    items: widget.listString
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
                ))
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
                    color: (_like == true) ? Colors.red[400] : iconColors,
                    tooltip: 'Next page',
                    onPressed: () async {
                      print("Press Like");
                      var result = await arrayDaoController.onClickLike(
                          widget.postId, widget.userIdSession);
                      print("Result on like ==>> $result");
                      setState(() {
                        if (result == "liked") {
                          _like = true;
                          widget.checkLike = "liked";
                          var countLike = int.parse(widget.totalLike);
                          countLike = countLike + 1;
                          widget.totalLike = "$countLike";
                        } else {
                          _like = false;
                          widget.checkLike = "unliked";
                          var countLike = int.parse(widget.totalLike);
                          countLike = countLike - 1;
                          widget.totalLike = "$countLike";
                        }
                      });
                      print("Like is $_like");
                    },
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
                    child: (widget.totalLike == "0")
                        ? SizedBox()
                        : Text(
                            "ถูกใจ ${widget.totalLike} คน",
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
                    "${widget.username}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(" "),
                  Text("${widget.postDescript}")
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
}

class KeepAlive extends StatefulWidget {
  KeepAlive({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _KeepAliveState createState() => _KeepAliveState();
}

class _KeepAliveState extends State<KeepAlive>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    /// Dont't forget this
    super.build(context);

    return widget.child;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
