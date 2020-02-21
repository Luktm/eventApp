
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import './helpers/hex_color.dart';

import './screens/login_screen.dart';
import './screens/onboarding_screen.dart';
import './screens/home_screen.dart';
import './screens/programme_screen.dart';
import './screens/login_screen.dart';
import './screens/lucky_draw_screen.dart';
import './screens/notification_screen.dart';


import './screens/programme_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Color primaryColor = HexColor("#1C93C2");
  final Color backgroundColor = HexColor('#FAFEFF');
  final Color accentColor = HexColor('#DEF6FF');
  // final Color subtitleColor = HexColor('#3C3C3C');
  final Color subtitleColor = HexColor('#000000');

  final Brightness brightness = Brightness.light;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final cupertinoTheme = new CupertinoThemeData(
      brightness: brightness, // if null will use the system theme
      primaryColor: CupertinoDynamicColor.withBrightness(
        color: primaryColor,
        darkColor: primaryColor,
      ),
    );

    return PlatformApp(
      title: 'Event Application',
      android: (_) => MaterialAppData(
        theme: ThemeData(
          primaryColor: primaryColor,
          backgroundColor: backgroundColor,
          accentColor: accentColor,
          textTheme: TextTheme(
                headline6: TextStyle(
                  color: primaryColor,
                ),
                subtitle1: TextStyle(
                  color: subtitleColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
        // darkTheme: materialDarkTheme,
        themeMode:
            brightness == Brightness.light ? ThemeMode.light : ThemeMode.dark,
      ),
      ios: (_) => CupertinoAppData(theme: cupertinoTheme, color: primaryColor),
      home: LuckyDrawScreen(),
    );
  }
}
