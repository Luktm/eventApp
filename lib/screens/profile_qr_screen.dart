import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

import '../helpers/custom_route.dart';
import '../helpers/hex_color.dart';

import './qr_full_screen.dart';

class ProfileQRScreen extends StatefulWidget {
  @override
  _ProfileQRScreenState createState() => _ProfileQRScreenState();
}

class _ProfileQRScreenState extends State<ProfileQRScreen> {
  GlobalKey globalKey = new GlobalKey();

  String _inputErrorText;
  final TextEditingController _textController = TextEditingController();

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

    // const double _topSectionTopPadding = 50.0;
    // const double _topSectionBottomPadding = 20.0;
    // const double _topSectionHeight = 50.0;

    const double qrRadius = 20.0;

    String _dataString = "Hello from this";
    String tagName = 'qrcode';

    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30, left: 25, right: 25, bottom: 5),
            padding: EdgeInsets.all(20),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
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
                Container(
                  // margin: EdgeInsets.only(top: 10),
                  width: deviceData.size.width * 0.4,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(qrRadius)),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
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
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            CustomRoute(
                              builder: (ctx) => QRFullScreen(
                                // qrData: _dataString,
                                // tagName: tagName,
                              ),
                              settings: RouteSettings(arguments: {'tagName': tagName, 'qrData': _dataString})
                            )
                            // platformPageRoute(
                            //   context: context,
                            //   builder: (BuildContext context) => QRFullScreen(
                            //     tagName: tagName,
                            //     qrData: _dataString,
                            //   ),
                            // ),
                            ),
                        child: Hero(
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
                          child: Text(
                            "uncheck-in".toUpperCase(),
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.red,
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
                  style: TextStyle(
                    color: HexColor.greyColor,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: <Widget>[
                      personalInfo('ID', '12345'),
                      SizedBox(
                        height: 20,
                      ),
                      personalInfo('Mobile No', '0123456789'),
                      SizedBox(
                        height: 20,
                      ),
                      personalInfo('Table No', '30'),
                      SizedBox(
                        height: 20,
                      ),
                      personalInfo('Full Name', 'John Doe')
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
              print('nani');
            },
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
