import 'package:flutter/material.dart';
import 'package:hellogram/app/screens/register/register_page.dart';

class LoginBottom extends StatefulWidget {
  @override
  _LoginBottomState createState() => _LoginBottomState();
}

class _LoginBottomState extends State<LoginBottom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'ยังไม่มีบัญชีผู้ใช้ใช่หรือไม่',
            style: TextStyle(),
          ),
          Container(
            margin: EdgeInsets.only(),
            child: FlatButton(
              onPressed: () {
                /*...*/
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return RegisterPage();
                }));
              },
              child: Text(
                "สมัครใช้งาน",
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
