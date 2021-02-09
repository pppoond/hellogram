import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                left: 12,
                right: 12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 130,
                    height: 130,
                    child: CircleAvatar(
                      //(Profile Image != null) ? Net..... : Net ........... ,
                      backgroundImage: NetworkImage(
                          "https://scontent.fkkc3-1.fna.fbcdn.net/v/t1.0-9/119569607_2778170449107098_5240304765195049180_n.jpg?_nc_cat=103&ccb=2&_nc_sid=09cbfe&_nc_ohc=5iI__DFY4l8AX8SFv8K&_nc_ht=scontent.fkkc3-1.fna&oh=db4e918037d34c3abb1391192251a5ce&oe=60471883"),
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Siwat Laothong",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            "pondwick",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.location_city),
                              SizedBox(
                                width: 12.0,
                              ),
                              Text(
                                "data",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(
                left: 12,
                right: 12,
              ),
              child: Center(
                child: Text(
                    "asdlehfsdfnsldjhfehDnls;djf;lakdjf;alksdj;laksdj;alksdja;lksda;lsfafbkjdhfkdfjhsdbfmxnbfks"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
