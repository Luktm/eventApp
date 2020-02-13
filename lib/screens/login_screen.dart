import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../widgets/scaffold_widget.dart';
import '../widgets/logo_widget.dart';

class LoginScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();
  bool _eyeoff = true;

  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context).size;

    return ScaffoldWidget(
      bodyChild: SingleChildScrollView(
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
                    bottomLeft: const Radius.circular(200.0),
                    bottomRight: const Radius.circular(200.0),
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
                child: LogoWidget(height: 120,),
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
                      color: ThemeData.light().textTheme.subtitle.color,
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
                          style: TextStyle(color: ThemeData.light().primaryColor),
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
                            ]),
                        child: PlatformTextField(
                          // style: TextStyle(height: 1.7, fontSize: 20),
                          android: (_) => MaterialTextFieldData(
                            controller: emailController,
                            onChanged: (String text) {
                              setState(() {
                                email = text;
                              });
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                          ios: (_) => CupertinoTextFieldData(
                              controller: emailController,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                color: Colors.white,
                              ),

                              // style: TextStyle(height: 2.0, ),
                              onChanged: (String text) {
                                setState(() {
                                  email = text;
                                });
                              }),
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
                          style: TextStyle(color: ThemeData.light().primaryColor),
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
                            ]),
                        child: PlatformTextField(
                          //  style: TextStyle(height: 1.7, fontSize: 20),
                          android: (_) => MaterialTextFieldData(
                            obscureText: true,
                            onChanged: (String text) {
                              setState(() {
                                password = text;
                              });
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                          ios: (_) => CupertinoTextFieldData(
                              obscureText: true,
                              controller: passwordController,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                color: Colors.white,
                              ),
                              // style: TextStyle(height: 2.0, ),
                              onChanged: (String text) {
                                setState(() {
                                  password = text;
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
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        child: RaisedButton(
                          color: ThemeData.light().primaryColor,
                          onPressed: () {},
                          child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 20),),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
