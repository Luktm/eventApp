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

class QRFullScreen extends StatelessWidget {
  static const routeName = '/qr-fullscreen';

  // final tagName;
  // final qrData;

  // QRFullScreen({this.tagName, this.qrData}) : super();

  @override
  Widget build(BuildContext context) {
    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;

    final modalData = ModalRoute.of(context).settings.arguments as Map;
    final tagName = modalData['tagName'];
    final qrData = modalData['qrData'];

    // print({"modalData": modalData});

    return PlatformScaffold(
      appBar: Platform.isIOS ?  PlatformAppBar(title: Text('QR Code'),) : null,
      body: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          child: Center(
            child: Hero(
              tag: Platform.isAndroid ? tagName: UniqueKey(),
              child: QrImage(
                size: bodyHeight * 0.3,
                data: qrData,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
