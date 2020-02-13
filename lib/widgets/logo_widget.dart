import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final double height;
  LogoWidget({this.height});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        'assets/images/event-logo.png',
        height: height,
      ),
    );
  }
}
