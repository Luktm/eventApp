import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io' show Platform;
import 'package:intl/intl.dart';

import '../helpers/hex_color.dart';
import '../helpers/date.dart';

import '../widgets/logo_widget.dart';
import '../widgets/card_widget.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreen createState() => _LocationScreen();
}

class _LocationScreen extends State<LocationScreen> {
  Completer<GoogleMapController> _controller = Completer();

  static final LatLng _initCenter = LatLng(3.1354, 101.6857);

  LatLng _lastMapPosition = _initCenter;

  static final LatLng _center =
      LatLng(_initCenter.latitude + 0.000500, _initCenter.longitude);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  // String weekday(weekdayInt) {
  //   switch (weekdayInt) {
  //     case 1:
  //       return 'Mon';
  //       break;
  //     case 2:
  //       return 'Tue';
  //       break;
  //     case 3:
  //       return 'Wed';
  //       break;
  //     case 4:
  //       return 'Thu';
  //     case 5:
  //       return 'Fri';
  //     case 6:
  //       return 'Sat';
  //     case 7:
  //       return 'Sun';
  //       break;
  //     default:
  //       return 'No Day';
  //   }
  // }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double locationInfoSizebWidth = 20.0;
    final double locationInfoSizedBoxMargin = 20.0;
    final double tableRowSizedBoxHeight = 30;

    // final DateTime now = DateTime.now();
    // final String formattedDate = DateFormat('yyyy MMM dd').format(now);
    // final int weekdayInt = now.weekday;

    return Container(
      height: double.infinity,
      child: SingleChildScrollView(
        child: CardWidget(
          title: 'Venue & Event Detail',
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Location Map',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 12,
                  color: HexColor.accentColor,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              // width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              height: 130,
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: GoogleMap(
                      rotateGesturesEnabled: false,
                      scrollGesturesEnabled: false,
                      tiltGesturesEnabled: false,
                      buildingsEnabled: false,
                      gestureRecognizers: Set()
                        ..add(Factory<PanGestureRecognizer>(
                            () => PanGestureRecognizer()))
                        ..add(Factory<ScaleGestureRecognizer>(
                            () => ScaleGestureRecognizer()))
                        ..add(Factory<TapGestureRecognizer>(
                            () => TapGestureRecognizer()))
                        ..add(Factory<VerticalDragGestureRecognizer>(
                            () => VerticalDragGestureRecognizer())),
                      compassEnabled: false,
                      zoomGesturesEnabled: false,
                      mapType: MapType.normal,
                      myLocationEnabled: true,
                      mapToolbarEnabled: false,
                      myLocationButtonEnabled: false,
                      onMapCreated: _onMapCreated,
                      markers: {
                        Marker(
                          markerId: MarkerId(
                            _lastMapPosition.toString(),
                          ),
                          position: _lastMapPosition,
                          // infoWindow: InfoWindow(
                          //     title: "Location Place",
                          //     snippet: '5 star hotel'),
                          icon: BitmapDescriptor.defaultMarker,
                        ),
                      },
                      initialCameraPosition: CameraPosition(
                        target: _center,
                        zoom: 15.0,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Opacity(
                      opacity: 0,
                      child: RaisedButton(
                        color: Colors.transparent,
                        disabledColor: Colors.transparent,
                        onPressed: () => MapsLauncher.launchCoordinates(
                            _initCenter.latitude, _initCenter.longitude),
                        // child: Text('abc'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Table(
              // border: TableBorder.all(),
              // defaultColumnWidth: FlexColumnWidth(0.3),
              columnWidths: {
                0: FractionColumnWidth(.3),
                // 1: FractionColumnWidth(.1)
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  children: [
                    Text(
                      'Venue',
                      style: TextStyle(color: HexColor.greyColor),
                    ),
                    Text(
                      'Hillton Kuala Lumpur Dining',
                      style: TextStyle(
                        color: HexColor.accentColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    SizedBox(
                      height: tableRowSizedBoxHeight,
                    ),
                    SizedBox(
                      height: tableRowSizedBoxHeight,
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Text(
                      'Date ',
                      style: TextStyle(color: HexColor.greyColor),
                    ),
                    Text(
                      '${Date.formattedDate} (${Date.weekday()})',
                      style: TextStyle(
                        color: HexColor.accentColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    SizedBox(
                      height: tableRowSizedBoxHeight,
                    ),
                    SizedBox(
                      height: tableRowSizedBoxHeight,
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Text(
                      'Time',
                      style: TextStyle(color: HexColor.greyColor),
                    ),
                    Text(
                      '7pm-9pm ',
                      style: TextStyle(
                        color: HexColor.accentColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ButtonTheme(
              minWidth: 200.0,
              child: RaisedButton(
                child: Text(
                  'Open Map',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: Platform.isAndroid ?  Theme.of(context).primaryColor : HexColor.primaryColor,
                onPressed: () => MapsLauncher.launchCoordinates(
                  _initCenter.latitude,
                  _initCenter.longitude,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
