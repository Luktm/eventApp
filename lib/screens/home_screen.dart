import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'dart:io' show Platform;

import '../screens/location_screen.dart';
import '../screens/login_screen.dart';
import '../screens/lucky_draw_screen.dart';
import '../screens/notification_screen.dart';
import '../screens/profile_qr_screen.dart';
import '../screens/programme_screen.dart';
import '../screens/qr_full_screen.dart';

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
  ];

  final List<String> _title = [
    'Location',
    'Programme',
    'Lucky Draw',
    'Profile',
  ];

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

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    return PlatformScaffold(
        // key: _globalKey,
        ios: (_) => CupertinoPageScaffoldData(
              navigationBar: CupertinoNavigationBar(
                transitionBetweenRoutes: false,
                heroTag: UniqueKey(),
                middle: Text(_title[_currentIndex]),
                trailing: CupertinoButton(
                        onPressed: () => Navigator.pushNamed(
                            context, NotificationScreen.routeName),
                        child: Icon(
                          CupertinoIcons.bell,
                        ),
                      )
                    ,
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
                ],
              ),
              body: SafeAreaWidget(
                child: SafeAreaWidget(
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: deviceData.size.height,
                    ),
                    color: backgroundColor,
                    // child: widget.bodyChild,
                    child: _children[_currentIndex],
                  ),
                ),
              ),
            ),
        android: (_) => MaterialScaffoldData(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  _title[_currentIndex],
                ),
                actions: _currentIndex == 0
                    ? [
                        IconButton(
                          onPressed: () => Navigator.of(context)
                              .pushNamed(NotificationScreen.routeName),
                          icon: Icon(
                            Icons.notifications_none,
                          ),
                        ),
                      ]
                    : null,
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
        );
  }
}
