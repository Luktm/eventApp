import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';

import '../widgets/card_widget.dart';

import '../helpers/hex_color.dart';

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

  @override
  void initState() {
    // _boxOneController.addListener(() {print('abc');});
    super.initState();
  }

  @override
  void dispose() {
    _boxOneController.dispose();
    _boxTwoController.dispose();
    _boxThreeController.dispose();
    _boxFourController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context).size;

    // var list = [1000, 3904, 3948, 1938, 1038];

    // final _random = new Random();

    // var element = list[_random.nextInt(list.length)];

    return  SingleChildScrollView(
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
                      width: 40,
                      // height: 50,
                      child: TextFormField(
                        controller: _boxOneController,
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
                          color: Theme.of(context).primaryColor,
                        ),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color: Theme.of(context).primaryColor),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
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
                      // height: 50,
                      child: TextFormField(
                        controller: _boxTwoController,
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
                          color: Theme.of(context).primaryColor,
                        ),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color: Theme.of(context).primaryColor),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
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
                      // height: 50,
                      child: TextFormField(
                        controller: _boxThreeController,
                        focusNode: _boxThreeFocusNode,
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
                          color: Theme.of(context).primaryColor,
                        ),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color: Theme.of(context).primaryColor),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
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
                      // height: 50,
                      child: TextFormField(
                        controller: _boxFourController,
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
                          color: Theme.of(context).primaryColor,
                        ),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color: Theme.of(context).primaryColor),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
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
          ],
        ),
      );
  }
}
