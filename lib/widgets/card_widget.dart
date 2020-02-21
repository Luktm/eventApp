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

class CardWidget extends StatelessWidget {
  // wanna change lne and time bottom sizedBox, change sizedHeight

  final String title;
  final List<Widget> children;
  
  CardWidget({this.title, this.children});

  static final   double sizedHeight = 30;
  static final  double programmeNameSizeHeight = 15.5;
  static final  double timeLinePaddingTop = 18.0;

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
        color:containerPrimaryColor?  HexColor.primaryColor : HexColor('#F2F2F2'),
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
        style: TextStyle(color: containerPrimaryColor ? Colors.white: HexColor.primaryColor, fontSize: 14),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
          children: <Widget>[
            LogoWidget(
              imgHeight: 100,
              paddingTop: 30,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 5,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ...children,
                        
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        );

  }
}
