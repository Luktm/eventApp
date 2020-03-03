import 'package:event_app/widgets/logo_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var currentPageValue;
  var _isInit = true;

  PageController controller = PageController();

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
            'PHONE NUMBER REGISTER',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: ThemeData.light().primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc eleifend.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: ThemeData.light().primaryColor,
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
            'assets/images/onboarding-01.png',
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'PHONE NUMBER REGISTER',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: ThemeData.light().primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc eleifend.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: ThemeData.light().primaryColor,
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
      body: Container(
        // height: deviceData.size.height,
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
                    onPressed: () {
                      print('abc');
                    },
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: ThemeData.light().primaryColor,
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
                    color: ThemeData.light().primaryColor,
                    onPressed: () async{
                      final prefs  = await SharedPreferences.getInstance();

                        prefs.setBool('firstTimeLogin', false);
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
