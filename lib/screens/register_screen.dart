import 'dart:convert';

import 'package:event_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:http/http.dart' as http;

import '../helpers/hex_color.dart';

import '../widgets/safe_area_widget.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register-screen';

  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  final Color backgroundColor = HexColor('#FAFEFF');

  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneNumController = TextEditingController();
  final _luckyDrawController = TextEditingController();

  var _isLoading = false;

  Future<void> createAccount() async {
    setState(() {
      _isLoading = true;
    });

    var url = 'https://cems.jnghng.com/api/registration';

    try {
      final response = await http.post(
        url,
        headers: {'Content-type': 'application/json'},
        body: json.encode({
          "name": _usernameController.text,
          "email": _emailController.text,
          "mobile": _phoneNumController.text,
          "password": _passwordController.text,
          "lucky": _luckyDrawController.text
        }),
      );

      if (response.body == 'This email have already been used') {
        throw (response.body);
      }

      // final responseData = json.decode(response.body) as Map<String, dynamic>; // use bad api so cannot decode

      showPlatformDialog(
        context: context,
        builder: (ctx) => PlatformAlertDialog(
          title: Text('Account Created'),
          content: Text('Your account has been created'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () => Navigator.popUntil(
                  context, ModalRoute.withName(Navigator.defaultRouteName)),
            )
          ],
        ),
      );
    } catch (err) {
      showPlatformDialog(
        context: context,
        builder: (ctx) => PlatformAlertDialog(
          title: Text('Error Occurt'),
          content: Text(err.toString()),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () => Navigator.popUntil(
                  context, ModalRoute.withName(Navigator.defaultRouteName)),
            )
          ],
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      
      appBar: PlatformAppBar(
        title: Text('Register'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: SafeAreaWidget(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: backgroundColor,
            child: Column(
              
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          // SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Register An Account',
                              style: TextStyle(
                                fontSize: 26,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Username',
                                  ),
                                ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     blurRadius: 1.0,
                                    //     spreadRadius: 1.0,
                                    //     offset: Offset(2, 1),
                                    //     color: Colors.grey[300],
                                    //   )
                                    // ],
                                  ),
                                  child: PlatformTextField(
                                    controller: _usernameController,
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Email Address',
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //       blurRadius: 1.0,
                                    //       spreadRadius: 1.0,
                                    //       offset: Offset(2, 1),
                                    //       color: Colors.grey[300])
                                    // ],
                                  ),
                                  child: PlatformTextField(
                                    controller: _emailController,
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Phone Number',
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //       blurRadius: 1.0,
                                    //       spreadRadius: 1.0,
                                    //       offset: Offset(2, 1),
                                    //       color: Colors.grey[300])
                                    // ],
                                  ),
                                  child: PlatformTextField(
                                    
                                    maxLength: 11,
                                    keyboardType: TextInputType.number,
                                    controller: _phoneNumController,
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Lucky Draw',
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     blurRadius: 1.0,
                                    //     spreadRadius: 1.0,
                                    //     offset: Offset(2, 1),
                                    //     color: Colors.grey[300],
                                    //   )
                                    // ],
                                  ),
                                  child: PlatformTextField(
                                    keyboardType: TextInputType.number,
                                    maxLength: 4,
                                    controller: _luckyDrawController,
                                  ),
                                ),
                                // SizedBox(
                                //   height: 30,
                                // ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Password',
                                  ),
                                ),

                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //       blurRadius: 1.0,
                                    //       spreadRadius: 1.0,
                                    //       offset: Offset(2, 1),
                                    //       color: Colors.grey[300])
                                    // ],
                                  ),
                                  child: PlatformTextField(
                                    obscureText: true,
                                    controller: _passwordController,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ButtonTheme(
                  minWidth: double.infinity,
                  height: 50,
                  buttonColor: HexColor.primaryColor,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap ,
                  child: RaisedButton(
                    onPressed: () {
                      if (_emailController.text.isEmpty ||
                          _passwordController.text.isEmpty ||
                          _usernameController.text.isEmpty) {
                        return showPlatformDialog(
                          context: context,
                          builder: (ctx) => PlatformAlertDialog(
                            title: Text('Please fill it up'),
                            content: Text("Field cannot be empty"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('ok'),
                                onPressed: () => Navigator.pop(
                                  context,
                                ),
                              )
                            ],
                          ),
                        );
                      }

                      return createAccount();
                    },
                    child: Text(
                      'Create Account',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
