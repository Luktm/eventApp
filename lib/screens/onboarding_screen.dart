import 'dart:io' show Platform;

import 'package:event_app/widgets/logo_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/auth.dart';

import '../helpers/hex_color.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var currentPageValue = 0;
  var _isInit = true;
  

  PageController controller = PageController(initialPage: 0, keepPage: false);

  List<Widget> introWidgets = [
    Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Image.asset(
            'assets/images/onboarding-01.png',
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Map & Details',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: HexColor.primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'See event location and click open the map.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: HexColor.primaryColor,
              ),
            ),
          )
        ],
      ),
    ),
    Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Image.asset(
            'assets/images/onboarding-02.png',
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Programme',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: HexColor.primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'List programme and time will indicate current event.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                 color: HexColor.primaryColor,
              ),
            ),
          )
        ],
      ),
    ),
    Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Image.asset(
            'assets/images/onboarding-03.png',
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Lucky Draw',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: HexColor.primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Lucky draw number will show in lucky draw session.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                 color: HexColor.primaryColor,
              ),
            ),
          )
        ],
      ),
    ),
    Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Image.asset(
            'assets/images/onboarding-04.png',
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Profile QR Code',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: HexColor.primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'show your qr code to receptionist for attendance',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                 color: HexColor.primaryColor,
              ),
            ),
          )
        ],
      ),
    ),
  ];

  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
          color: isActive ? Theme.of(context).primaryColor : Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }

  void getChangedPageAndMoveBar(int page) {
    print({"currentPageValue": page});
    currentPageValue = page;
    setState(() {});
  }

  final List<Widget> introWidgetsList = <Widget>[];

  @override
  void didChangeDependencies() {
    if (_isInit) {
      for (var i = 0; i < introWidgets.length; i++) {
        introWidgetsList.add(introWidgets[i]);
      }
    }

    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    return PlatformScaffold(
      body: SingleChildScrollView(
        child: Container(
          // height: deviceData.size.height,
          color: Colors.white,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: (deviceData.size.height -
                        deviceData.padding.top -
                        deviceData.padding.bottom) *
                    0.3,
                // color: Colors.red,
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: LogoWidget(
                    paddingTop: 0,
                    imgHeight: 130,
                    // paddingTop: 10,
                  ),
                ),
              ),
              Container(
                height: (deviceData.size.height -
                        deviceData.padding.top -
                        deviceData.padding.bottom) *
                    0.5,
                alignment: Alignment.center,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    PageView.builder(
                      physics: ClampingScrollPhysics(),
                      itemCount: introWidgetsList.length,
                      onPageChanged: (int page) {
                        getChangedPageAndMoveBar(page);
                      },
                      controller: controller,
                      itemBuilder: (context, index) {
                        return introWidgetsList[index];
                      },
                    ),
                    Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for (int i = 0; i < introWidgetsList.length; i++)
                          if (i == currentPageValue) ...[circleBar(true)] else
                            circleBar(false),
                      ],
                    ),

                    // Positioned(
                    //   right: 20,
                    //   bottom: 20,
                    //   child: Visibility(
                    //     visible: currentPageValue == introWidgetsList.length - 1
                    //         ? true
                    //         : false,
                    //     child: FloatingActionButton(
                    //       backgroundColor: Theme.of(context).primaryColor,
                    //       onPressed: () async {
                    //         SharedPreferences prefs =
                    //             await SharedPreferences.getInstance();

                    //         prefs.setBool('seen', true);

                    //         // Provider.of<Auth>(context).firstTimeLogin();
                    //       },
                    //       shape: RoundedRectangleBorder(
                    //           borderRadius:
                    //               BorderRadius.all(Radius.circular(30))),
                    //       child: Icon(
                    //         Icons.arrow_forward,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              Container(
                // color: Colors.grey,
                height: (deviceData.size.height -
                        deviceData.padding.top -
                        deviceData.padding.bottom) *
                    0.2,
                // margin: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () async {
                        Provider.of<Auth>(context, listen: false)
                            .firstTimeLoginMethod();
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color:  Platform.isAndroid ?  Theme.of(context).primaryColor : HexColor.primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Text(
                        'Next',
                        style: TextStyle(color: Colors.white),
                      ),
                      color:  Platform.isAndroid ?  Theme.of(context).primaryColor : HexColor.primaryColor,
                      onPressed: () async {
                        if (currentPageValue >= (introWidgets.length-1)) {
                          return Provider.of<Auth>(context, listen: false)
                              .firstTimeLoginMethod();
                        }

                        if (controller.hasClients) {
                          controller.animateToPage(
                            ++currentPageValue,
                            duration: Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
