import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../helpers/hex_color.dart';
import '../widgets/safe_area_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = '/forgot-password-screen';

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  Future<bool> emailValidator(context) async {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);

    if (!regex.hasMatch(_emailController.text)) {
      return Fluttertoast.showToast(
        msg: "Please insert valid email",
        gravity: ToastGravity.TOP,
      );
    }

    return showPlatformDialog(
      context: context,
      builder: (ctx) => PlatformAlertDialog(
        title: Text('Email correct'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Ok'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    return PlatformScaffold(
      appBar: PlatformAppBar(
        // title: Text(''),
        // leading: PlatformIconButton(),
        // trailingActions: <Widget>[
        //   PlatformIconButton(),
        // ],
        android: (_) => MaterialAppBarData(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
            color: HexColor.primaryColor,
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          // iconTheme: IconThemeData(color: HexColor.primaryColor,  )
        ),
        ios: (_) => CupertinoNavigationBarData(),
      ),
      backgroundColor: Colors.white,
      body: SafeAreaWidget(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Forgot Password',
                  style: TextStyle(
                    color: HexColor.primaryColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                'Please enter your email address, you will receive a link to create a new password via email',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 7), // changes position of shadow
                      ),
                    ],
                  ),
                  child: PlatformTextField(
                    android: (_) => MaterialTextFieldData(
                      // onChanged: (String text) {
                      //   if (text.contains('@')) {

                      //   }
                      // },
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: HexColor.primaryColor,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    ios: (_) => CupertinoTextFieldData(
                      controller: _emailController,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.white,
                      ),
                      // onChanged: (String text) {
                      //   if (!text.contains('@')) {}
                      // }
                      // style: TextStyle(height: 2.0, ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ButtonTheme(
                minWidth: 180,
                height: 50,
                child: RaisedButton(
                  color: HexColor.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  onPressed: () => emailValidator(context),
                  child: Text(
                    'Send',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: (deviceData.size.width -
                                deviceData.padding.bottom) *
                            0.05),
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
