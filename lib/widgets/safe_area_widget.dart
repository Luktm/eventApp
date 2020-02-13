import 'package:flutter/material.dart';

class SafeAreaWidget extends StatelessWidget {
  final Widget child;

  SafeAreaWidget({this.child});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topLeft,
        child: Container(
          color: Colors.white,
          child: SafeArea(
            // left: true,
            top: true,
            // right: true,
            // bottom: true,
            // minimum: const EdgeInsets.all(16.0),
            child: child,
          ),
        ));
  }
}
