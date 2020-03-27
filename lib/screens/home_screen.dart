import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'dart:io' show Platform;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../screens/location_screen.dart';
import '../screens/login_screen.dart';
import '../screens/lucky_draw_screen.dart';
import '../screens/notification_screen.dart';
import '../screens/profile_qr_screen.dart';
import '../screens/programme_screen.dart';
import '../screens/qr_full_screen.dart';
import '../screens/setting_screen.dart';

import '../widgets/safe_area_widget.dart';
import '../helpers/hex_color.dart';

class HomeScreen extends StatefulWidget {
  // final String title;
  // final bool hasAppbar;
  // final List<Widget> appbarButton;
  // final Widget bodyChild;

  // ScaffoldWidget({
  //   this.title,
  //   this.hasAppbar = false,
  //   this.appbarButton,
  //   this.bodyChild,
  // });

  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final Color backgroundColor = new HexColor('#FAFEFF');
  int _currentIndex = 0;

  final GlobalKey _globalKey = GlobalKey();
  final CupertinoTabController _cupertinoTabController =
      CupertinoTabController();

  final List<Widget> _children = [
    LocationScreen(),
    ProgrammeScreen(),
    LuckyDrawScreen(),
    ProfileQRScreen(),
    SettingScreen(),
  ];

  final List<String> _title = [
    'Location',
    'Programme',
    'Lucky Draw',
    'Profile',
    'Setting'
  ];

  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();
  var ioSubscription;

  @override
  void initState() {
    // _fcm.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     print("onMessage: $message");

    //     showPlatformDialog(
    //       context: context,
    //       builder: (context) => AlertDialog(
    //         content: ListTile(
    //           title: Text(message['notification']['title']),
    //           subtitle: Text(message['notification']['body']),
    //         ),
    //         actions: <Widget>[
    //           FlatButton(
    //             child: Text('ok'),
    //             onPressed: () => Navigator.of(context).pop(),
    //           ),
    //         ],
    //       ),
    //     );
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print("onLaunch: $message");
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print("onResume: $message");
    //   },
    // );

    // _fcm.subscribeToTopic('puppies');

    // if (Platform.isIOS) {
    //   ioSubscription = _fcm.onIosSettingsRegistered.listen((event) {
    //     _saveDeviceToken();
    //   });

    //   _fcm.requestNotificationPermissions(IosNotificationSettings());
    // } else {
    //   _saveDeviceToken();
    // }

    // _fcm.getToken().then((token) => print(token));

    // _fcm.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     print("onMessage: $message");
    //   },

    //   onLaunch: (Map<String, dynamic> message) async {
    //     print("onLaunch: $message");
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print("onResume: $message");
    //   },
    // );

    _saveDeviceToken();

    super.initState();
  }

  _saveDeviceToken() async {
    String uid = 'jeffd23';

    try {
      final fcmToken = await _fcm.getToken();

      if (fcmToken != null) {
        var tokenRef = _db
            .collection('users')
            .document(uid)
            .collection('tokens')
            .document(fcmToken);

        await tokenRef.setData({
          'token': fcmToken,
          'createdAt': FieldValue.serverTimestamp(),
          'platform': Platform.operatingSystem
        });
      }
    } catch (error) {
      print(error);
    }
  }

  Widget platformAppBar() {
    return PlatformAppBar(
      title: Center(
          child: Text(
        _title[_currentIndex],
        textAlign: TextAlign.center,
      )),
      trailingActions: _currentIndex == 0
          ? [
              PlatformIconButton(
                iosIcon: Icon(CupertinoIcons.bell),
                androidIcon: Icon(Icons.notifications_none),
                onPressed: () => Navigator.push(
                  context,
                  platformPageRoute(
                    maintainState: false,
                    builder: (
                      BuildContext context,
                    ) =>
                        NotificationScreen(),
                    context: context,
                  ),
                ),
              ),
            ]
          : null,
    );
  }

  Future<bool> _exitApp(BuildContext context) {
    return showDialog(
          context: context,
          child: new AlertDialog(
            title: new Text('Do you want to exit this application?'),
            content: new Text('We hate to see you leave...'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: PlatformScaffold(
        key: _globalKey,
        ios: (_) => CupertinoPageScaffoldData(
          navigationBar: CupertinoNavigationBar(
            previousPageTitle: 'home',
            transitionBetweenRoutes: false,
            heroTag: UniqueKey(),
            middle: Text(_title[_currentIndex]),
            trailing: CupertinoButton(
              onPressed: () =>
                  Navigator.pushNamed(context, NotificationScreen.routeName),
              child: Icon(
                CupertinoIcons.bell,
              ),
            ),
          ),
          controller: _cupertinoTabController,
          bottomTabBar: CupertinoTabBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(
              () {
                _currentIndex = index;
              },
            ),
            items: [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.location),
                title: Text('Location'),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.news),
                title: Text('Programme'),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.bookmark),
                title: Text('Lucky Draw'),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person),
                title: Text('Profile'),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.settings),
                title: Text('Setting'),
              ),
            ],
          ),
          body: SafeAreaWidget(
            child: Container(
              height: double.infinity,
              color: backgroundColor,
              // child: widget.bodyChild,
              child: _children[_currentIndex],
            ),
          ),
        ),
        android: (_) => MaterialScaffoldData(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              _title[_currentIndex],
            ),
            actions: [
              IconButton(
                onPressed: () => Navigator.of(context)
                    .pushNamed(NotificationScreen.routeName),
                icon: Icon(
                  Icons.notifications_none,
                ),
              ),
            ],
          ),
          body: SafeAreaWidget(
            child: Container(
              color: backgroundColor,
              // child: widget.bodyChild,
              child: _children[_currentIndex],
            ),
          ),
          bottomNavBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.location_on,
                ),
                title: Text('Location'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                title: Text('List'),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.local_activity,
                ),
                title: Text('Lucky Draw'),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                title: Text('Profile'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                title: Text('Setting'),
              ),
            ],
            type: BottomNavigationBarType.fixed,
          ),
        ),
        bottomNavBar: PlatformNavBar(),
        // backgroundColor: backgroundColor,
        // appBar: platformAppBar(),
        // body: SafeAreaWidget(
        //   child: Container(
        //     color: backgroundColor,
        //     // child: widget.bodyChild,
        //     child: _children[_currentIndex],
        //   ),
        // ),
        // bottomNavBar: PlatformNavBar(
        //   currentIndex: _currentIndex,
        //   itemChanged: (index) => setState(() {
        //     _currentIndex = index;
        //   }),
        //   items: [
        //     BottomNavigationBarItem(
        //       icon: Icon(
        //         Icons.location_on,
        //       ),
        //       title: Text('Location'),
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.list),
        //       title: Text('List'),
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(
        //         Icons.local_activity,
        //       ),
        //       title: Text('Lucky Draw'),
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(
        //         Icons.person,
        //       ),
        //       title: Text('Profile'),
        //     ),
        //   ],
        // ),
        // iosContentPadding: false,
        // iosContentBottomPadding: false,
      ),
    );
  }
}
