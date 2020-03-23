import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import './helpers/hex_color.dart';

import './providers/auth.dart';
import './providers/profile.dart';

import './screens/login_screen.dart';
import './screens/onboarding_screen.dart';
import './screens/home_screen.dart';
import './screens/programme_screen.dart';
import './screens/login_screen.dart';
import './screens/lucky_draw_screen.dart';
import './screens/notification_screen.dart';
import './screens/profile_qr_screen.dart';
import './screens/programme_screen.dart';
import './screens/qr_full_screen.dart';
import './screens/splash_screen.dart';
import './screens/login_screen.dart';
import './screens/forgot_password_screen.dart';
import './screens/update_password_screen.dart';
import './screens/privacy_policy_screen.dart';
import './screens/feedback_screen.dart';
import './screens/setting_screen.dart';
import './screens/register_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Color primaryColor = HexColor("#01147A");
  final Color backgroundColor = HexColor('#FAFEFF');
  final Color accentColor = HexColor('#3C3C3C');
  // final Color subtitleColor = HexColor('#3C3C3C');
  final Color subtitleColor = HexColor('#000000');

  final Brightness brightness = Brightness.light;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final cupertinoTheme =  CupertinoThemeData(
      brightness: brightness, // if null will use the system theme
      primaryColor: CupertinoDynamicColor.withBrightness(
        color: primaryColor,
        darkColor: primaryColor,
      ),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Profile>(
          // create: (_) => Provider.of<Profile>(context),
          update: (_, auth, previousProfile) => Profile(
            auth.email,
            auth.apiBaseUrl,
            // previousProfile == null ? [] : previousProfile.item
          ),
        )
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => PlatformApp(
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
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // darkTheme: materialDarkTheme,
            themeMode: brightness == Brightness.light
                ? ThemeMode.light
                : ThemeMode.dark,
          ),
          ios: (_) => CupertinoAppData(
            theme: cupertinoTheme,
            color: primaryColor,
          ),
          home: auth.isAuth
              ? !auth.firstTimeLogin ? HomeScreen() : OnboardingScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authSnapshot) =>
                      authSnapshot.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : LoginScreen(),
                ),
          routes: {
            QRFullScreen.routeName: (ctx) => QRFullScreen(),
            NotificationScreen.routeName: (ctx) => NotificationScreen(),
            ProfileQRScreen.routeName: (ctx) => ProfileQRScreen(),
            ForgotPasswordScreen.routeName: (ctx) => ForgotPasswordScreen(),
            UpdatePasswordScreen.routeName: (ctx) => UpdatePasswordScreen(),
            PrivacyPolicyScreen.routeName: (ctx) => PrivacyPolicyScreen(),
            SettingScreen.routeName: (ctx) => SettingScreen(),
            FeedbackScreen.routeName: (ctx) => FeedbackScreen(),
            RegisterScreen.routeName: (ctx) => RegisterScreen()
          },
        ),
      ),
    );
  }
}
