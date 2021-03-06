
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:fluttertoast/fluttertoast.dart';

import '../helpers/hex_color.dart';
import '../providers/auth.dart';

import '../screens/register_screen.dart';

import '../widgets/logo_widget.dart';

import './forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {

  static const routeName = '/login-screen';
  
  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  FocusNode _passwordFocusNode = FocusNode();
  bool _isLoading = false;

  bool _eyeoff = true;

  var _isInit = true;

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  @override
  void didChangeDependencies() {
    if (_isInit) {}
    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    _passwordFocusNode.dispose();
    super.dispose();
  }

  void showDialogMessage(BuildContext context, String message) {
    showPlatformDialog(
      context: context,
      builder: (ctx) => PlatformAlertDialog(
        title: Text('Warning'),
        content: Text(
          message.toString(),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context).size;

    return PlatformScaffold(
      key: const ValueKey('/'),
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  // padding: EdgeInsets.symmetric(vertical: 30),
                  margin: EdgeInsets.only(bottom: 10),
                  alignment: Alignment.center,
                  height: 220.0,
                  width: deviceData.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(200.0),
                      bottomRight: Radius.circular(200.0),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 7), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Container(
                    padding: EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/event-logo.png',
                      height: 120,
                    ),
                  ),
                  padding: EdgeInsets.only(top: 30),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 30, right: 20),
                        child: Divider(
                          height: 20,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Text(
                      'Sign In',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.subtitle1.color,
                        fontSize: 14,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 20, right: 30),
                        child: Divider(
                          height: 20,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: PlatformText(
                            'Email',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Platform.isAndroid
                                  ? Theme.of(context).primaryColor
                                  : HexColor.primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          // height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset:
                                    Offset(0, 7), // changes position of shadow
                              ),
                            ],
                          ),
                          child: PlatformTextField(
                            android: (_) => MaterialTextFieldData(
                              controller: emailController,
                              onSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_passwordFocusNode);
                              },
                              onChanged: (String text) {
                                setState(() {
                                  _authData['email'] = text;
                                });
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                            ios: (_) => CupertinoTextFieldData(
                              onSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_passwordFocusNode);
                              },
                              controller: emailController,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                color: Colors.white,
                              ),
                              // style: TextStyle(height: 2.0, ),
                              onChanged: (String text) {
                                setState(() {
                                  _authData['email'] = text;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: PlatformText(
                            'Password',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Platform.isAndroid
                                  ? Theme.of(context).primaryColor
                                  : HexColor.primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          // height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  offset: Offset(
                                      0, 7), // changes position of shadow
                                ),
                              ]),
                          child: PlatformTextField(
                            //  style: TextStyle(height: 1.7, fontSize: 20),
                            android: (_) => MaterialTextFieldData(
                              focusNode: _passwordFocusNode,
                              obscureText: true,
                              onChanged: (String text) {
                                setState(() {
                                  _authData['password'] = text;
                                });
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                            ios: (_) => CupertinoTextFieldData(
                                focusNode: _passwordFocusNode,
                                obscureText: true,
                                controller: passwordController,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.0),
                                  color: Colors.white,
                                ),
                                // style: TextStyle(height: 2.0, ),
                                onChanged: (String text) {
                                  setState(() {
                                    _authData['password'] = text;
                                  });
                                }),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        ButtonTheme(
                          minWidth: deviceData.width,
                          height: 45.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: RaisedButton(
                            color: Platform.isAndroid
                                ? Theme.of(context).primaryColor
                                : HexColor.primaryColor,
                            onPressed: () async {
                              if (_authData['email'].isEmpty) {
                                return showDialogMessage(
                                    context, 'Email must be fill');
                              } else if (_authData['password'].isEmpty) {
                                return showDialogMessage(
                                    context, 'Password must be given');
                              } else if (!_authData['email'].contains('@')) {
                                return showDialogMessage(
                                    context, 'Please insert Valid Email');

                                // return Fluttertoast.showToast(
                                //   msg: "Please insert Valid Email",
                                //   toastLength: Toast.LENGTH_SHORT,
                                //   gravity: ToastGravity.TOP,
                                //   timeInSecForIos: 1,
                                //   // backgroundColor: Colors.red,
                                //   // textColor: Colors.white,
                                //   fontSize: 16.0,
                                // );
                              } else if (_authData['password'].length < 3) {
                                return showDialogMessage(context,
                                    'Password must be more than 3 character');

                                // return Fluttertoast.showToast(
                                //   msg: "Password must be more than 3 character",
                                //   toastLength: Toast.LENGTH_SHORT,
                                //   gravity: ToastGravity.TOP,
                                //   timeInSecForIos: 1,
                                //   // backgroundColor: Colors.red,
                                //   // textColor: Colors.white,
                                //   fontSize: 16.0,
                                // );
                              }

                              try {
                                setState(() {
                                  _isLoading = true;
                                });

                                await Provider.of<Auth>(context, listen: false)
                                    .login(
                                  _authData['email'],
                                  _authData['password'],
                                );
                              } catch (err) {
                                showDialogMessage(context, err.toString());
                              } finally {
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // FlatButton(
                        //   onPressed: () => Navigator.pushNamed(context, ForgotPasswordScreen.routeName),
                        //   child: Text(
                        //     'Forgot Password',
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                FlatButton(child: Text("Don't have Account?"), onPressed: ()=>Navigator.pushNamed(context, RegisterScreen.routeName),),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
