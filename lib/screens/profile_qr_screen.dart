import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:screen/screen.dart';
import '../helpers/custom_route.dart';
import '../helpers/hex_color.dart';

import './qr_full_screen.dart';
import '../screens/login_screen.dart';
import '../screens/update_password_screen.dart';



import '../providers/auth.dart';

class ProfileQRScreen extends StatefulWidget {
  static const routeName = '/profile-qr-screen';

  @override
  _ProfileQRScreenState createState() => _ProfileQRScreenState();
}

class _ProfileQRScreenState extends State<ProfileQRScreen> {
  GlobalKey globalKey = new GlobalKey();

  var _isInit = true;
  Timer _timer;

  String _inputErrorText;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    if (_isInit) {
      _timer = Timer.periodic(Duration(seconds: 3), (Timer t) {
        Provider.of<Auth>(context, listen: false)
            .profileKeepFetch()
            // .then((value) => setState(() {}))
            .catchError(
              (err) => print(err),
            );
      });
    }

    _isInit = false;

    super.initState();
  }

  Future<void> _captureAndSharePng() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.png').create();
      await file.writeAsBytes(pngBytes);
      final channel = MethodChannel('channel:me.alfian.share/share');
      await channel.invokeMethod('shareFile', 'image.png');
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  /* _contentWidget() {
    final bodyHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom;

    return Container(
      color: const Color(0xFFFFFFFF),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: _topSectionTopPadding,
              left: 20.0,
              right: 10.0,
              bottom: _topSectionBottomPadding,
            ),
            child: Container(
              height: _topSectionHeight,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: "Enter a custom message",
                        errorText: _inputErrorText,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: FlatButton(
                      child: Text("SUBMIT"),
                      onPressed: () {
                        setState(() {
                          _dataString = _textController.text;
                          _inputErrorText = null;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: RepaintBoundary(
                key: globalKey,
                child: QrImage(
                  data: _dataString,
                  size: 0.5 * bodyHeight,
                  errorStateBuilder: (BuildContext context, Object obj) =>
                      AlertDialog(
                    title: Text('Qr Errro Occur'),
                    content: Text('Please try again'),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('ok'),
                        onPressed: () => Navigator.of(context).pop(),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  } */

  Widget personalInfo(String title, String description) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            textAlign: TextAlign.left,
            style: TextStyle(color: HexColor.greyColor),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            description,
            textAlign: TextAlign.left,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);
    final auth = Provider.of<Auth>(context);
    // const double _topSectionTopPadding = 50.0;
    // const double _topSectionBottomPadding = 20.0;
    // const double _topSectionHeight = 50.0;

    const double qrRadius = 20.0;

    String _dataString = auth.id.toString();
    String tagName = 'qrcode';

    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;

    return Container(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 30, left: 25, right: 25, bottom: 5),
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 7), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: PlatformIconButton(
                      onPressed: () => Navigator.of(context).pushNamed(UpdatePasswordScreen.routeName),
                      iosIcon: Icon(
                        CupertinoIcons.settings,
                        size: 28.0,
                        color: Colors.grey,
                      ),
                      androidIcon: Icon(
                        Icons.settings,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Container(
                    // margin: EdgeInsets.only(top: 10),
                    width: deviceData.size.width * 0.4,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Platform.isAndroid
                              ? Theme.of(context).primaryColor
                              : HexColor.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(qrRadius)),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            final navData = await Navigator.push(
                              context,
                              CustomRoute(
                                  page: QRFullScreen(
                                qrData: _dataString,
                                tagName: tagName,
                              )
                                  // builder: (ctx) => QRFullScreen(
                                  //     qrData: _dataString,
                                  //     tagName: tagName,
                                  //     ),
                                  //   settings: RouteSettings(
                                  //     arguments: {
                                  //       'tagName': tagName,
                                  //       'qrData': _dataString
                                  //     },
                                  //   ),
                                  ),
                              // platformPageRoute(
                              //   context: context,
                              //   builder: (BuildContext context) => QRFullScreen(
                              //     tagName: tagName,
                              //     qrData: _dataString,
                              //   ),
                              // ),
                            );

                            // if (navData == 'done') {
                            //   Screen.setBrightness(0.3);
                            // }
                          },

                          // onTap: () {
                          //   showPlatformDialog(
                          //     context: context,
                          //     builder: (_) => PlatformAlertDialog(
                          //       content: Container(
                          //         decoration: BoxDecoration(color: Colors.transparent),
                          //         height: deviceData.size.height, // Change as per your requirement
                          //         width: deviceData.size.width, // Change as per your requirement
                          //         child: GestureDetector(
                          //           onTap: () => Navigator.of(context).pop(),
                          //           child: Center(
                          //             child: Hero(
                          //               tag: Platform.isAndroid
                          //                   ? tagName
                          //                   : UniqueKey(),
                          //               child: QrImage(
                          //                 size: bodyHeight * 0.3,
                          //                 data: _dataString,
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   );
                          // },
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Tap Enlarge',
                                style: TextStyle(
                                  color: HexColor.greyColor,
                                  fontSize: 18,
                                ),
                              ),
                              Hero(
                                tag: Platform.isAndroid ? tagName : UniqueKey(),
                                child: RepaintBoundary(
                                  key: globalKey,
                                  child: QrImage(
                                    data: _dataString,
                                    size: 0.2 * bodyHeight,
                                    errorStateBuilder:
                                        (BuildContext context, Object obj) =>
                                            AlertDialog(
                                      title: Text('Qr Errro Occur'),
                                      content: Text('Please try again'),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('ok'),
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: HexColor('#F2F2F2'),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(qrRadius),
                                bottomRight: Radius.circular(qrRadius)),
                          ),
                          height: 30,
                          child: OverflowBox(
                            child: GestureDetector(
                              onTap: () {
                                Fluttertoast.showToast(
                                  msg: auth.status == 'Unregistered'
                                      ? "Please show your qr code for attendance"
                                      : 'You have registered',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.TOP,
                                  fontSize: 16.0,
                                );

                                // final snackbar = SnackBar(
                                //   content: Text(
                                //     'Please show your barcode to make attendance',
                                //   ),
                                //   duration: Duration(milliseconds: 1000),
                                // );

                                // Scaffold.of(context).showSnackBar(snackbar);
                              },
                              child: Text(
                                auth.status.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 13,
                                  color: auth.status == 'Unregistered'
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'QR Code for Attendance Check-in',
                    style: TextStyle(color: HexColor.greyColor, fontSize: 14),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: <Widget>[
                        // personalInfo('ID', auth.id.toString()),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        personalInfo('Mobile No', auth.mobile.toString()),
                        SizedBox(
                          height: 20,
                        ),
                        personalInfo('Table No', auth.table.toString()),
                        SizedBox(
                          height: 20,
                        ),
                        personalInfo('Full Name', auth.name.toString())
                      ],
                    ),
                  ),
                ],
              ),
            ),
            FlatButton(
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                // if use drawer push navigator just use the navigator pop
                // Navigator.pop(context);

                // Navigator.of(context).pushReplacementNamed('/');

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
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
