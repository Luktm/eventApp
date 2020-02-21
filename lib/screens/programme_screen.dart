import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../helpers/hex_color.dart';
import '../helpers/date.dart';

import '../widgets/scaffold_widget.dart';
import '../widgets/logo_widget.dart';
import '../widgets/card_widget.dart';

class ProgrammeScreen extends StatelessWidget {
  // wanna change lne and time bottom sizedBox, change sizedHeight
  static double sizedHeight = 30;
  static double programmeNameSizeHeight = 15.5;
  final double timeLinePaddingTop = 18.0;

  Widget sizedHeightWidget() {
    return SizedBox(
      height: sizedHeight,
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

  Widget lineWidget() {
    return Container(
      width: 1,
      height: sizedHeight + 10,
      color: HexColor.greyColor,
    );
  }

  Widget timeWidget(BuildContext context, String time) {
    return Text(
      time,
      style: Theme.of(context).textTheme.subtitle1,
    );
  }

  Widget programNameSizedWidget() {
    return SizedBox(
      height: programmeNameSizeHeight,
    );
  }

  Widget programContainerWidget({bool containerPrimaryColor}) {
    return Container(
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
        'Neque porro quisquam est qui ',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: containerPrimaryColor ? Colors.white : HexColor.primaryColor,
            fontSize: 14),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appbarButton: <Widget>[],
      hasAppbar: true,
      title: 'Programme',
      bodyChild: SingleChildScrollView(
        child: CardWidget(
          title: 'Programme Agenda',
          children: <Widget>[
            Text(
              '${Date.formattedDate} (${Date.weekday()})',
              style: TextStyle(
                fontSize: 12,
                color: ThemeData.light().primaryColor,
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
                      timeWidget(context, '7pm'),
                      sizedHeightWidget(),
                      timeWidget(context, '7.30pm'),
                      sizedHeightWidget(),
                      timeWidget(context, '8pm'),
                      sizedHeightWidget(),
                      timeWidget(context, '8.30pm'),
                      sizedHeightWidget(),
                      timeWidget(context, '9pm'),
                      sizedHeightWidget(),
                      timeWidget(context, '9.30pm'),
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
                      lineWidget(),
                      circleBoxWidget(),
                      lineWidget(),
                      circleBoxWidget(),
                      lineWidget(),
                      circleBoxWidget(),
                      lineWidget(),
                      circleBoxWidget(),
                      lineWidget(),
                      circleBoxWidget(),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  children: <Widget>[
                    programContainerWidget(
                      containerPrimaryColor: true,
                    ),
                    programNameSizedWidget(),
                    programContainerWidget(
                      containerPrimaryColor: false,
                    ),
                    programNameSizedWidget(),
                    programContainerWidget(
                      containerPrimaryColor: true,
                    ),
                    programNameSizedWidget(),
                    programContainerWidget(
                      containerPrimaryColor: false,
                    ),
                    programNameSizedWidget(),
                    programContainerWidget(
                      containerPrimaryColor: true,
                    ),
                    programNameSizedWidget(),
                    programContainerWidget(
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
