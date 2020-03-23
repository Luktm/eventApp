import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../widgets/card_widget.dart';

import '../helpers/hex_color.dart';

import '../providers/auth.dart';

class LuckyDrawScreen extends StatefulWidget {
  @override
  _LuckyDrawScreenState createState() => _LuckyDrawScreenState();
}

class _LuckyDrawScreenState extends State<LuckyDrawScreen> {
  final _formKey = GlobalKey<FormState>();
  final _boxOneController = TextEditingController();
  final _boxTwoController = TextEditingController();
  final _boxThreeController = TextEditingController();
  final _boxFourController = TextEditingController();

  FocusNode _boxOneFocusNode = FocusNode();
  FocusNode _boxTwoFocusNode = FocusNode();
  FocusNode _boxThreeFocusNode = FocusNode();
  FocusNode _boxFourFocusNode = FocusNode();

  bool _isInit = true;

  Timer _timer;

  @override
  void initState() {
    // _boxOneController.addListener(() {print('abc');});
    // print('luckydarw');
    super.initState();
  }

  @override
  void didUpdateWidget(LuckyDrawScreen oldWidget) {
    print({"didupdate widget": oldWidget});
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _timer = Timer.periodic(
        Duration(seconds: 3),
        (Timer t) {
          Provider.of<Auth>(context, listen: false)
              .profileKeepFetch()
              // .then((value) => setState(() {}))
              .catchError(
                (err) => print(err),
              );
        },
      );
    }

    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _boxOneController.dispose();
    _boxTwoController.dispose();
    _boxThreeController.dispose();
    _boxFourController.dispose();

    _timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context).size;
    final auth = Provider.of<Auth>(context);

    // print({"this":auth.lucky});
    // var list = [1000, 3904, 3948, 1938, 1038];

    // final _random = new Random();

    // var element = list[_random.nextInt(list.length)];

    return Container(
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        child: CardWidget(
          title: 'Lucky Draw',
          children: <Widget>[
            // SizedBox(
            //   height: 20,
            // ),
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: Text(
            //     'Available Lucky Draw Number',
            //     textAlign: TextAlign.center,
            //     style: TextStyle(color: HexColor.accentColor, fontSize: 11),
            //   ),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // Container(
            //   // color: Colors.red,
            //   height: 30,
            //   width: double.infinity,
            //   child: ListView(
            //     addAutomaticKeepAlives: true,
            //     cacheExtent: 10,
            //     scrollDirection: Axis.horizontal,
            //     children: <Widget>[
            //       Container(
            //         alignment: Alignment.center,
            //         // width: 100,
            //         padding: EdgeInsets.symmetric(horizontal: 20),
            //         decoration: BoxDecoration(
            //             border: Border.all(
            //               color: Theme.of(context).primaryColor,
            //             ),
            //             borderRadius: BorderRadius.circular(30)),
            //         child: Text(
            //           '1930',
            //           textAlign: TextAlign.center,
            //           style: TextStyle(
            //             color: Theme.of(context).primaryColor,
            //           ),
            //         ),
            //       ),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       Container(
            //         alignment: Alignment.center,
            //         // width: 100,
            //         padding: EdgeInsets.symmetric(horizontal: 20),
            //         decoration: BoxDecoration(
            //             border: Border.all(
            //               color: Theme.of(context).primaryColor,
            //             ),
            //             borderRadius: BorderRadius.circular(30)),
            //         child: Text(
            //           '2094',
            //           textAlign: TextAlign.center,
            //           style: TextStyle(
            //             color: Theme.of(context).primaryColor,
            //           ),
            //         ),
            //       ),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       Container(
            //         alignment: Alignment.center,
            //         // width: 100,
            //         padding: EdgeInsets.symmetric(horizontal: 20),
            //         decoration: BoxDecoration(
            //             border: Border.all(
            //               color: Theme.of(context).primaryColor,
            //             ),
            //             borderRadius: BorderRadius.circular(30)),
            //         child: Text(
            //           '2094',
            //           textAlign: TextAlign.center,
            //           style: TextStyle(
            //             color: Theme.of(context).primaryColor,
            //           ),
            //         ),
            //       ),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       Container(
            //         alignment: Alignment.center,
            //         // width: 100,
            //         padding: EdgeInsets.symmetric(horizontal: 20),
            //         decoration: BoxDecoration(
            //             border: Border.all(
            //               color: Theme.of(context).primaryColor,
            //             ),
            //             borderRadius: BorderRadius.circular(30)),
            //         child: Text(
            //           '2094',
            //           textAlign: TextAlign.center,
            //           style: TextStyle(
            //             color: Theme.of(context).primaryColor,
            //           ),
            //         ),
            //       ),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       Container(
            //         alignment: Alignment.center,
            //         // width: 100,
            //         padding: EdgeInsets.symmetric(horizontal: 20),
            //         decoration: BoxDecoration(
            //             border: Border.all(
            //               color: Theme.of(context).primaryColor,
            //             ),
            //             borderRadius: BorderRadius.circular(30)),
            //         child: Text(
            //           '2094',
            //           textAlign: TextAlign.center,
            //           style: TextStyle(
            //             color: Theme.of(context).primaryColor,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 20,
            ),
            Container(
              // padding: EdgeInsets.symmetric(horizontal: 40),
              child: Form(
                key: _formKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: Platform.isAndroid
                              ? Theme.of(context).primaryColor
                              : HexColor.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: 40,
                      // height: 50,
                      child: TextFormField(
                        // controller: _boxOneController,
                        initialValue: auth.lucky != null
                            ? auth.lucky.substring(0, 1)
                            : null,
                        enabled: false,
                        focusNode: _boxOneFocusNode,
                        onChanged: (String text) {
                          if (text.isNotEmpty) {
                            FocusScope.of(context)
                                .requestFocus(_boxTwoFocusNode);
                          }
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_boxTwoFocusNode);
                        },
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Platform.isAndroid
                                ? Theme.of(context).primaryColor
                                : HexColor.primaryColor),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Platform.isAndroid ? Theme.of(context).primaryColor : HexColor.primaryColor,
                            ),
                          ),
                          border: OutlineInputBorder(
                            // borderRadius: BorderRadius.all(
                            //   Radius.circular(10),
                            // ),
                            borderSide: BorderSide(
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 2,
                            color: Platform.isAndroid
                                ? Theme.of(context).primaryColor
                                : HexColor.primaryColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      // height: 50,
                      child: TextFormField(
                        initialValue: auth.lucky != null
                            ? auth.lucky.substring(1, 2)
                            : null,
                        // controller: _boxTwoController,
                        enabled: false,
                        focusNode: _boxTwoFocusNode,
                        onChanged: (String text) {
                          if (text.isNotEmpty) {
                            FocusScope.of(context)
                                .requestFocus(_boxThreeFocusNode);
                          } else if (text.isEmpty) {
                            FocusScope.of(context)
                                .requestFocus(_boxOneFocusNode);
                          }
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_boxThreeFocusNode);
                        },
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Platform.isAndroid
                              ? Theme.of(context).primaryColor
                              : HexColor.primaryColor,
                        ),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Platform.isAndroid
                                  ? Theme.of(context).primaryColor
                                  : HexColor.primaryColor,
                            ),
                          ),
                          border: OutlineInputBorder(
                            // borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: Platform.isAndroid
                              ? Theme.of(context).primaryColor
                              : HexColor.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: 40,
                      // height: 50,
                      child: TextFormField(
                        initialValue: auth.lucky != null
                            ? auth.lucky.substring(2, 3)
                            : null,
                        // controller: _boxThreeController,
                        focusNode: _boxThreeFocusNode,
                        enabled: false,
                        onChanged: (String text) {
                          if (text.isNotEmpty) {
                            FocusScope.of(context)
                                .requestFocus(_boxFourFocusNode);
                          } else if (text.isEmpty) {
                            FocusScope.of(context)
                                .requestFocus(_boxTwoFocusNode);
                          }
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_boxFourFocusNode);
                        },
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Platform.isAndroid
                              ? Theme.of(context).primaryColor
                              : HexColor.primaryColor,
                        ),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              // borderSide: BorderSide(
                              //     width: 2, color: Theme.of(context).primaryColor),
                              ),
                          border: OutlineInputBorder(
                            // borderRadius: BorderRadius.all(
                            //   Radius.circular(10),
                            // ),
                            borderSide: BorderSide(
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: Platform.isAndroid
                              ? Theme.of(context).primaryColor
                              : HexColor.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      // height: 50,
                      child: TextFormField(
                        initialValue: auth.lucky != null
                            ? auth.lucky.substring(3, 4)
                            : null,
                        enabled: false,
                        // controller: _boxFourController,
                        focusNode: _boxFourFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        onChanged: (String text) {
                          if (text.isNotEmpty) {
                            FocusScope.of(context).requestFocus(FocusNode());
                          } else if (text.isEmpty) {
                            FocusScope.of(context)
                                .requestFocus(_boxThreeFocusNode);
                          }
                          print('boxfourt Chnage');
                        },
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Platform.isAndroid
                              ? Theme.of(context).primaryColor
                              : HexColor.primaryColor,
                        ),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Platform.isAndroid
                                  ? Theme.of(context).primaryColor
                                  : HexColor.primaryColor,
                            ),
                          ),
                          border: OutlineInputBorder(
                            // borderRadius: BorderRadius.all(
                            //   Radius.circular(10),
                            // ),
                            borderSide: BorderSide(
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Your Lucky Draw Number',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: Text(
                'This is your lucky draw number, your lucky draw number will show on the stage to get the gift.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: HexColor.accentColor,
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // RaisedButton(
            //   padding: EdgeInsets.symmetric(horizontal: 50),
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(30),
            //   ),
            //   color: Theme.of(context).primaryColor,
            //   onPressed: () {},
            //   child: Text(
            //     'Submit',
            //     style: TextStyle(color: Colors.white),
            //   ),
            // ),
            // Text(auth.lucky.substring(0, 1))
          ],
        ),
      ),
    );
  }
}
