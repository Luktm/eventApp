import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';
import 'package:screen/screen.dart';

class QRFullScreen extends StatefulWidget {
  static const routeName = '/qr-fullscreen';

  final tagName;
  final qrData;

  QRFullScreen({this.tagName, this.qrData}) : super();

  @override
  _QRFullScreenState createState() => _QRFullScreenState();
}

class _QRFullScreenState extends State<QRFullScreen> {
  var _isInit = true;
  bool _isKeptOn = false;
  double _brightness = 1.0;

  @override
  void initState() {
    // Screen.setBrightness(_brightness);
    // initPlatformState();
    super.initState();
  }

  // Future<void> initPlatformState() async {
  //   bool keptOn = await Screen.isKeptOn;
  //   double brightness = await Screen.brightness;

  //   setState(() {
  //     _isKeptOn = keptOn;
  //     _brightness = brightness;
  //   });
  // }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;

    // final modalData = ModalRoute.of(context).settings.arguments as Map;
    // final tagName = modalData['tagName'];
    // final qrData = modalData['qrData'];

    return PlatformScaffold(
        appBar: Platform.isIOS
            ? PlatformAppBar(
                title: Text('QR Code'),
              )
            : null,
        body: GestureDetector(
          onTap: () => Navigator.of(context).pop('done'),
          child: Container(
            margin: EdgeInsets.all(20.0),
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                // color: Color(0xFFB4C56C).withOpacity(0.01),
                // borderRadius: BorderRadius.all(Radius.circular(50.0)),
                ),
            child: Center(
              child: Hero(
                tag: Platform.isAndroid ? widget.tagName : UniqueKey(),
                child: Container(
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(10),
                  //   border: Border.all(
                  //     color: Theme.of(context).primaryColor,
                  //     width: 10,
                  //   ),
                  // ),
                  child: QrImage(
                    size: bodyHeight * 0.35,
                    data: widget.qrData,
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
