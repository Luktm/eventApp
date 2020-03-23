import 'package:event_app/screens/feedback_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/auth.dart';

import '../widgets/card_widget.dart';
import '../widgets/cupertino_listtile_widget.dart';

import './privacy_policy_screen.dart';
import './update_password_screen.dart';

class SettingScreen extends StatefulWidget {
  static const routeName = '/setting-screen';
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _key = GlobalKey();

  bool emailNotificatonVal = false;

  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.containsKey('emailVal')) {
        setState(() {
          emailNotificatonVal = prefs.getBool('emailVal');
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    return SizedBox.expand(
      key: _key,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey[300]),
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(30)),
              // height: 20,
              width: deviceData.size.width * 0.5,
              child: Text(
                "MAIN",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            PlatformWidget(
              ios: (_) => ListView(
                 physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                  CupertinoListTile(
                    onTap: () => Navigator.of(context)
                        .pushNamed(UpdatePasswordScreen.routeName),
                    title: 'Password Reset',
                    trailing: Icon(
                      CupertinoIcons.right_chevron,
                      size: 30,
                    ),
                  )
                ],
              ),
              android: (_) => ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: ListTile(
                      onTap: () => Navigator.of(context)
                        .pushNamed(UpdatePasswordScreen.routeName),
                      title: Text(
                        'Password Reset',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                        ),
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    ),
                  ),
                  // Divider()
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey[300]),
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(30)),
              // height: 20,
              width: deviceData.size.width * 0.5,
              child: Text(
                "NOTIFICATIONS",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            PlatformWidget(
              ios: (_) => ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                  CupertinoListTile(
                    title: 'Email Notification',
                    trailing: PlatformSwitch(
                      value: emailNotificatonVal,
                      onChanged: (bool switchVal) async {
                        setState(() {
                          emailNotificatonVal = switchVal;
                        });

                        final prefs = await SharedPreferences.getInstance();

                        prefs.setBool('emailVal', switchVal);
                      },
                    ),
                  )
                ],
              ),
              android: (_) => ListView(
                 physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: ListTile(
                      title: Text(
                        'Email Notification',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                        ),
                      ),
                      trailing: PlatformSwitch(
                        value: emailNotificatonVal,
                        onChanged: (bool value) {
                          setState(() {
                            emailNotificatonVal = value;
                          });
                        },
                      ),
                    ),
                  ),
                  // Divider()
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey[300]),
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(30)),
              // height: 20,
              width: deviceData.size.width * 0.5,
              child: Text(
                "SUPPORT",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            PlatformWidget(
              ios: (_) => ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                  CupertinoListTile(
                    onTap: () => Navigator.pushNamed(
                        context, PrivacyPolicyScreen.routeName),
                    title: 'Privacy Policy',
                    trailing: Icon(
                      CupertinoIcons.right_chevron,
                      size: 30,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CupertinoListTile(
                    onTap: () =>
                        Navigator.pushNamed(context, FeedbackScreen.routeName),
                    title: 'Feedback',
                    trailing: Icon(
                      CupertinoIcons.right_chevron,
                      size: 30,
                    ),
                  ),
                ],
              ),
              android: (_) => ListView(
                 physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(
                            context, PrivacyPolicyScreen.routeName);
                      },
                      title: Text(
                        'Privacy Policy',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                        ),
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(
                            context, FeedbackScreen.routeName);
                      },
                      title: Text(
                        'Feedback',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                        ),
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    ),
                  ),
                  // Divider()
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FlatButton(
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                showPlatformDialog(
                  context: context,
                  builder: (_) => PlatformAlertDialog(
                    title: Text('Are you sure to Logout'),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Ok'),
                        onPressed: () {
                          Provider.of<Auth>(context, listen: false).logout();
                          Navigator.pop(context);
                        },
                      ),
                      FlatButton(
                        child: Text('Cancel'),
                        onPressed: () => Navigator.pop(context),
                      )
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
