import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hellogram/app/api/api.dart';
import 'package:hellogram/app/models/user/user.model.dart';
import 'package:hellogram/app/screens/login/login_page.dart';
import 'package:http/http.dart' as http;

class RegisterBody extends StatefulWidget {
  @override
  _RegisterBodyState createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  String register;
  _getRegister(UserModel userModel) async {
    //debugPrint('$');
    final res = await http.post(Api.registerUrl, body: {
      "name": userModel.getUsername,
      "username": userModel.getUserusername,
      "password": userModel.getUserpassword
    });
    final data = jsonDecode(res.body);
    debugPrint(data.toString());

    if (data == "success") {
      register = data.toString();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LoginPage();
      }));
    } else {}
  }

  TextEditingController _username = TextEditingController();
  TextEditingController _fullname = TextEditingController();
  TextEditingController _password = TextEditingController();

  final TextStyle textStyle = TextStyle(color: Colors.white);
  final buttonColor = Colors.blue;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Hellogram',
            style: TextStyle(
                color: Colors.black87, fontFamily: 'Billabong', fontSize: 50.0),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
            child: TextField(
              controller: _username,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
            child: TextField(
              controller: _fullname,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
            child: TextField(
              obscureText: true,
              controller: _password,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
            child: SizedBox(
              width: double.infinity,
              child: RaisedButton(
                color: buttonColor,
                onPressed: () {
                  UserModel userModel = new UserModel();
                  userModel.setUsername = _fullname.text;
                  userModel.setUserusername = _username.text;
                  userModel.setUserpassword = _password.text;
                  _getRegister(userModel);
                },
                child: Text(
                  "สมัครสมาชิก",
                  style: textStyle,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'มีบัญชีผู้ใช้งานแล้ว',
                style: TextStyle(
                  color: Colors.black87,
                ),
              ),
              Container(
                margin: EdgeInsets.only(),
                child: FlatButton(
                  onPressed: () {
                    /*...*/
                    Navigator.pop(context,
                        MaterialPageRoute(builder: (context) {
                      return LoginPage();
                    }));
                  },
                  child: Text(
                    "เข้าสู่ระบบ",
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
