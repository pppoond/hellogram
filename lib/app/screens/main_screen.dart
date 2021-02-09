import 'package:flutter/material.dart';
import 'package:hellogram/app/screens/array_widget/array_widget.dart';
import 'package:hellogram/app/screens/home/home_page.dart';
import 'package:hellogram/app/screens/login/login_page.dart';
import 'package:hellogram/app/screens/profile/profile_page.dart';
import 'package:hellogram/app/screens/slide_page/slide_page.dart';
import 'package:hellogram/app/utils/check_logged.dart';
import 'package:hellogram/app/widgets/icon_badge.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController;
  int _page = 0;
  dynamic _notify = false;
  var userIdSession;

  CheckLogged checkLogged = new CheckLogged();

  void checkLogin() async {
    var logged = await checkLogged.checkLogged();
    if (logged != null) {
      print("Logged Successfully");
      userIdSession = logged;
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => LoginPage(null)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: [
          KeepAlivePage(child: HomePage()),
          KeepAlivePage(child: ArrayWidget()),
          KeepAlivePage(child: CarouselDemo()),
          KeepAlivePage(child: ProfilePage())
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(width: 7.0),
            barIcon(icon: Icons.home, page: 0),
            barIcon(icon: Icons.search, page: 1),
            barIcon(icon: Icons.mode_comment, page: 2, badge: true),
            barIcon(icon: Icons.person, page: 3),
            SizedBox(width: 7.0),
          ],
        ),
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  Widget barIcon(
      {IconData icon = Icons.home, int page = 0, dynamic badge = false}) {
    return IconButton(
      icon: (badge == true)
          ? IconBadge(icon: icon, size: 24.0)
          : Icon(icon, size: 24.0),
      color: (_page == page)
          ? Theme.of(context).accentColor
          : Colors.blueGrey[300],
      onPressed: () {
        print("Press Tab index = $page");
        return _pageController.jumpToPage(page);
      },
    );
  }
}

class KeepAlivePage extends StatefulWidget {
  KeepAlivePage({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _KeepAlivePageState createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<KeepAlivePage>
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
