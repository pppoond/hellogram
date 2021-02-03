import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hellogram/app/api/api.dart';
import 'package:hellogram/app/models/list/list.model.dart';
import 'package:hellogram/app/screens/list/list_page.dart';
import 'package:http/http.dart' as http;

class LoginBody extends StatefulWidget {
  String register;

  LoginBody(this.register);
  @override
  _LoginBodyState createState() => _LoginBodyState(this.register);
}

class _LoginBodyState extends State<LoginBody> {
  String register;
  _LoginBodyState(this.register);
  final _text = TextEditingController();
  bool _validate = false;
  String msgError = "";

  _getLogin(String username, String password) async {
    debugPrint('$username');
    final res = await http
        .post(Api.loginUrl, body: {"username": username, "password": password});
    final data = jsonDecode(res.body);
    debugPrint(data.toString());

    if (data != null) {
      print(data[0]['user_id'].toString());
      _login();
      // _snackBarSucess();
      //Future.delayed(Duration(seconds: 3), _login);
      // _username.clear();
      // _password.clear();
      setState(() {
        msgError = "";
      });
    } else {
      setState(() {
        _snackBar();
        //msgError = "Username or Password is not correct!";
      });
    }
  }

  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Add Your Code here.
      debugPrint("Login Body Print Test $register");
      if (register == "success") {
        _snackBarRegister();
        register = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(color: Colors.white);
    final buttonColor = Colors.blue;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Hellogram',
            style: TextStyle(fontFamily: 'Billabong', fontSize: 50.0),
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
              controller: _password,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text('ลืมรหัสผ่านใช่หรือไม่'),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
            child: SizedBox(
              width: double.infinity,
              child: RaisedButton(
                color: buttonColor,
                onPressed: () {
                  _getLogin(_username.text, _password.text);
                },
                child: Text(
                  "เข้าสู่ระบบ",
                  style: textStyle,
                ),
              ),
            ),
          ),
          Center(
            child: Text(msgError, style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _snackBarRegister() {
    final snackBar = SnackBar(
        backgroundColor: Colors.blueAccent,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Register Sucessfuly'),
          ],
        ));

    // Find the Scaffold in the widget tree and use
    // it to show a SnackBar.
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _snackBar() {
    final snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Username or Password is not correct!'),
          ],
        ));

    // Find the Scaffold in the widget tree and use
    // it to show a SnackBar.
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _snackBarSucess() {
    final snackBar = SnackBar(
        backgroundColor: Colors.blueAccent,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Sucessfully'),
          ],
        ));

    // Find the Scaffold in the widget tree and use
    // it to show a SnackBar.
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _login() async {
    ListModel listModel = new ListModel();
    listModel.setUsername = _username.text;
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ListPage(listModel);
    }));

    //_showAlertDialog('Status', 'Login Successfully');
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );

    showDialog(context: context, builder: (_) => alertDialog);
  }
}
