import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final double imgHeight;
  final double paddingTop;
  LogoWidget({this.imgHeight, this.paddingTop = 0});
  
  @override
  Widget build(BuildContext context) {
    return Container(
       padding: EdgeInsets.only(top: paddingTop),
            alignment: Alignment.center,
      child: Image.asset(
        'assets/images/event-logo.png',
        height: imgHeight,
      ),
    );
  }
}
