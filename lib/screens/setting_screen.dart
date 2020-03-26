import 'dart:io';

import 'package:event_app/screens/feedback_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:image_picker/image_picker.dart';

import '../providers/auth.dart';

import '../widgets/card_widget.dart';
import '../widgets/cupertino_listtile_widget.dart';

import './privacy_policy_screen.dart';
import './update_password_screen.dart';

import '../helpers/hex_color.dart';

class SettingScreen extends StatefulWidget {
  static const routeName = '/setting-screen';
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _key = GlobalKey();

  File _storeImage;

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

  Future getImage(ImageSource cameraOption, BuildContext context) async {

    File imageFile = await ImagePicker.pickImage(
      maxWidth: 800,
      // imageQuality: 10,
      source: cameraOption,
      maxHeight: 800,
    );

    if (imageFile == null) {
      return;
    }

    Navigator.of(context).pop();

    final userName = Provider.of<Auth>(context, listen: false).name;

    // print('Original path: ${imageFile.path}'); // <- File: '/storage/emulated/0/Android/data/com.cspeed.event_app/files/Pictures/scaled_bf969277-887a-4618-8f2f-a449f311874e2119033349675260722.jpg'
    String dir = path.dirname(imageFile.path); // <- /storage/emulated/0/Android/data/com.cspeed.event_app/files/Pictures
    String newPath = path.join(dir, '${userName.toLowerCase()}-profile-img.jpg');
    // print('NewPath: $newPath'); // <- /storage/emulated/0/Android/data/com.cspeed.event_app/files/Pictures/newName.jpg
    imageFile = imageFile.renameSync(newPath);
    print(imageFile);

    setState(() {
      _storeImage = imageFile;
    });

    // final appDir = await syspaths.getApplicationDocumentsDirectory();
    // final fileName = path.basename(imageFile.path);
    // final saveImage = await imageFile.copy('${appDir.path}/$fileName');

    // print({
    //   "appDir": appDir,
    //   "fileName": fileName,
    //   "saveImage": saveImage,
    // });
  }

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    final profileImg = Provider.of<Auth>(context, listen: false).profileImage;
    final profileName = Provider.of<Auth>(context, listen: false).name;

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

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      showPlatformDialog(
                        context: context,
                        builder: (BuildContext context) => Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      child: Text(
                                        'Change Profile Picture',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Divider(),
                                    FlatButton(
                                      onPressed: () =>
                                          getImage(ImageSource.camera, context),
                                      child: Text(
                                        'Upload from Camera',
                                      ),
                                    ),
                                    FlatButton(
                                      onPressed: () => getImage(
                                          ImageSource.gallery, context),
                                      child: Text(
                                        'Upload from library',
                                      ),
                                    ),
                                    Divider(),
                                    FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      );
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: HexColor.primaryColor,
                      backgroundImage: profileImg == null
                          ? _storeImage == null
                              ? AssetImage(
                                  'assets/images/profile-placeholder.jpg')
                              : FileImage(_storeImage)
                          : NetworkImage(profileImg),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(profileName)
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            // Container(
            //   padding: EdgeInsets.symmetric(vertical: 6),
            //   decoration: BoxDecoration(
            //       border: Border.all(width: 1, color: Colors.grey[300]),
            //       color: Colors.grey[100],
            //       borderRadius: BorderRadius.circular(30)),
            //   // height: 20,
            //   width: deviceData.size.width * 0.5,
            //   child: Text(
            //     "MAIN",
            //     textAlign: TextAlign.center,
            //     style: TextStyle(
            //       color: Colors.grey,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
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
            // SizedBox(
            //   height: 30,
            // ),
            // Container(
            //   padding: EdgeInsets.symmetric(vertical: 6),
            //   decoration: BoxDecoration(
            //       border: Border.all(width: 1, color: Colors.grey[300]),
            //       color: Colors.grey[100],
            //       borderRadius: BorderRadius.circular(30)),
            //   // height: 20,
            //   width: deviceData.size.width * 0.5,
            //   child: Text(
            //     "NOTIFICATIONS",
            //     textAlign: TextAlign.center,
            //     style: TextStyle(
            //       color: Colors.grey,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 20,
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
            // SizedBox(
            //   height: 30,
            // ),
            // Container(
            //   padding: EdgeInsets.symmetric(vertical: 6),
            //   decoration: BoxDecoration(
            //       border: Border.all(width: 1, color: Colors.grey[300]),
            //       color: Colors.grey[100],
            //       borderRadius: BorderRadius.circular(30)),
            //   // height: 20,
            //   width: deviceData.size.width * 0.5,
            //   child: Text(
            //     "SUPPORT",
            //     textAlign: TextAlign.center,
            //     style: TextStyle(
            //       color: Colors.grey,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 20,
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
                        Navigator.pushNamed(context, FeedbackScreen.routeName);
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
