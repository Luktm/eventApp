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


import '../widgets/logo_widget.dart';

class CardWidget extends StatelessWidget {
  // wanna change lne and time bottom sizedBox, change sizedHeight

  final String title;
  final List<Widget> children;
  
  CardWidget({this.title, this.children});

  @override
  Widget build(BuildContext context) {

    var deviceData = MediaQuery.of(context);
    
    return  Column(
          children: <Widget>[
            LogoWidget(
              imgHeight: 60,
              paddingTop: 20,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: (deviceData.size.width - deviceData.padding.bottom) * 0.9,
              // padding: EdgeInsets.symmetric(horizontal: 20),
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
            ),
            SizedBox(height: 20,)
          ],
        );

  }
}
