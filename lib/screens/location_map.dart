import 'package:flutter/material.dart';

import '../widgets/scaffold_widget.dart';

class LocationMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (ScaffoldWidget(
      appbarButton: <Widget>[],
      hasAppbar: true,
      title: 'Location',
      bodyChild: Container(
        child: Text('abc'),
      ),
    ));
  }
}
