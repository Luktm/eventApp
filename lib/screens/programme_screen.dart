import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../helpers/hex_color.dart';
import '../helpers/date.dart';

import '../widgets/card_widget.dart';

class ProgrammeScreen extends StatelessWidget {
  // wanna change lne and time bottom sizedBox, change sizedHeight
  static double sizedHeight = 30;
  static double programmeNameSizeHeight = 18;
  final double timeLinePaddingTop = 18.0;

  Widget sizedHeightWidget() {
    return SizedBox(
      height: Platform.isAndroid ? sizedHeight + 5 : 35,
    );
  }

  Widget circleBoxWidget() {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: HexColor.greyColor,
      ),
    );
  }

  Widget lineWidget(deviceData) {
    return Container(
      width: 1,
      height:  (deviceData.size.height - deviceData.padding.bottom) * 0.06,
      color: HexColor.greyColor,
    );
  }

  Widget timeWidget(BuildContext context, String time, [deviceData]) {
    return Text(
      time,
      style: Platform.isAndroid
          ? Theme.of(context).textTheme.subtitle1
          : TextStyle(
              fontSize: (deviceData.size.width - deviceData.padding.bottom) * 0.033,
            ),
    );
  }

  Widget programNameSizedWidget() {
    return SizedBox(
      height: programmeNameSizeHeight,
    );
  }

  Widget programContainerWidget(deviceData, eventName,
      {bool containerPrimaryColor}) {
    return Container(
      constraints: BoxConstraints(
        minWidth: (deviceData.size.width - deviceData.padding.bottom) * 0.53,
      ),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color:
            containerPrimaryColor ? HexColor.primaryColor : HexColor('#F2F2F2'),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4.0, // has the effect of softening the shadow
            spreadRadius: 2.0, // has the effect of extending the shadow
            offset: Offset(
              2.0, // horizontal, move right 10
              3.0, // vertical, move down 10
            ),
          )
        ],
      ),
      child: Text(
        eventName,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: containerPrimaryColor ? Colors.white : HexColor.primaryColor,
          fontSize: (deviceData.size.width - deviceData.padding.bottom) * 0.03,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    return Container(
      height: double.infinity,
      
      child: SingleChildScrollView(
        child: CardWidget(
          title: 'Programme Agenda',
          children: <Widget>[
            Text(
              '${Date.formattedDate} (${Date.weekday()})',
              style: TextStyle(
                fontSize: 12,
                color:  Platform.isAndroid ?  Theme.of(context).primaryColor : HexColor.primaryColor,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: timeLinePaddingTop),
                  child: Column(
                    children: <Widget>[
                      timeWidget(context, '7pm', deviceData),
                      sizedHeightWidget(),
                      timeWidget(context, '7.30pm', deviceData),
                      sizedHeightWidget(),
                      timeWidget(context, '8pm', deviceData),
                      sizedHeightWidget(),
                      timeWidget(context, '8.30pm', deviceData),
                      sizedHeightWidget(),
                      timeWidget(context, '9pm', deviceData),
                      sizedHeightWidget(),
                      timeWidget(context, '9.30pm',deviceData),
                      sizedHeightWidget(),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(top: timeLinePaddingTop),
                  child: Column(
                    children: <Widget>[
                      circleBoxWidget(),
                      lineWidget(deviceData),
                      circleBoxWidget(),
                      lineWidget(deviceData),
                      circleBoxWidget(),
                      lineWidget(deviceData),
                      circleBoxWidget(),
                      lineWidget(deviceData),
                      circleBoxWidget(),
                      lineWidget(deviceData),
                      circleBoxWidget(),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    programContainerWidget(
                      deviceData,
                      'Registration and Check-In',
                      containerPrimaryColor: true,
                    ),
                    programNameSizedWidget(),
                    programContainerWidget(
                      deviceData,
                      'Event Announcement',
                      containerPrimaryColor: false,
                    ),
                    programNameSizedWidget(),
                    programContainerWidget(
                      deviceData,
                      'Starting Dinner',
                      containerPrimaryColor: true,
                    ),
                    programNameSizedWidget(),
                    programContainerWidget(
                      deviceData,
                      'Organizer and Guest Introduction',
                      containerPrimaryColor: false,
                    ),
                    programNameSizedWidget(),
                    programContainerWidget(
                      deviceData,
                      'Lucky Draw',
                      containerPrimaryColor: true,
                    ),
                    programNameSizedWidget(),
                    programContainerWidget(
                      deviceData,
                      'Event End',
                      containerPrimaryColor: false,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
