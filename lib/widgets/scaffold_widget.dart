import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../widgets/safe_area_widget.dart';
import '../helpers/hex_color.dart';

class ScaffoldWidget extends StatelessWidget {
  final String title;
  final bool hasAppbar;
  final List<Widget> appbarButton;
  final Widget bodyChild;

  final Color backgroundColor = new HexColor('#FAFEFF');

  ScaffoldWidget({
    this.title,
    this.hasAppbar = false,
    this.appbarButton,
    this.bodyChild,
  });

  Widget platformAppBar() {
    return PlatformAppBar(
      title: Center(
          child: Text(
        title,
        textAlign: TextAlign.center,
      )),
      trailingActions: appbarButton.toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      // backgroundColor: backgroundColor,
      appBar: this.hasAppbar ? platformAppBar() : null,
      body: SafeAreaWidget(
        child: Container(
          color: backgroundColor,
          child: bodyChild,
        ),
      ),
      iosContentPadding: false,
      iosContentBottomPadding: false,
    );
  }
}
