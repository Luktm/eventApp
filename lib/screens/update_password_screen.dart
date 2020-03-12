import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../helpers/hex_color.dart';

import '../widgets/safe_area_widget.dart';

import '../providers/auth.dart';
import '../providers/profile.dart';

class UpdatePasswordScreen extends StatefulWidget {
  static const routeName = '/update-password-screen';

  @override
  _UpdatePasswordScreenState createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _newPasswordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  bool _isLoading = false;

  void flutterShowToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
    );
  }

  Future<void> updatePassword(context) async {
    if (_oldPasswordController.text.isEmpty) {
      return flutterShowToast('Please insert old password');
    } else if (_newPasswordController.text.isEmpty) {
      return flutterShowToast('Please insert new password');
    } else if (_confirmPasswordController.text.isEmpty) {
      return flutterShowToast('Please insert confirm password');
    } else if (_newPasswordController.text != _confirmPasswordController.text) {
      return flutterShowToast('New password not match with confirm password');
    }

    try {
      setState(() {
        _isLoading = true;
      });

      var url = "http://192.168.68.116:8000/api/changepassword";

      final response = await http.post(
        url,
        // headers: {"Content-type": 'application/json'},
        body: {
          "email": Provider.of<Auth>(context, listen: false).email,
          "oldpassword": _oldPasswordController.text,
          "newpassword": _newPasswordController.text
        },
      );

      final responseData = response.body;

      // final responseData = json.decode(response.body);

      if (responseData == 'Your password is incorrect') {
        throw responseData;
      }

      flutterShowToast('Password Update Successful');

      return Future.delayed(Duration(milliseconds: 200), () {
        Navigator.of(context).pop();
      });
    } catch (err) {
      showPlatformDialog(
        context: context,
        builder: (ctx) => PlatformAlertDialog(
          content: Text(err.toString()),
          title: Text('Error Occur'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
        _oldPasswordController.text = '';
        _newPasswordController.text = '';
        _confirmPasswordController.text = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    return PlatformScaffold(
      backgroundColor: Colors.white,
      appBar: PlatformAppBar(
        title: Text('Reset Password'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: SafeAreaWidget(
          child: Container(
            height: double.infinity,
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  // Align(
                  //   alignment: Alignment.centerLeft,
                  //   child: Text(
                  //     'Reset Password',
                  //     style: TextStyle(
                  //       color: HexColor.primaryColor,
                  //       fontSize: 30,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 40),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Old Password',
                          style: TextStyle(
                            fontSize: 15,
                            color: HexColor.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        PlatformTextField(
                          onSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_newPasswordFocusNode);
                          },
                          controller: _oldPasswordController,
                          obscureText: true,
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(20)
                          ],
                        ),
                        SizedBox(height: 30),
                        Text(
                          'New Password',
                          style: TextStyle(
                              fontSize: 15,
                              color: HexColor.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        PlatformTextField(
                          focusNode: _newPasswordFocusNode,
                          onSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_confirmPasswordFocusNode);
                          },
                          controller: _newPasswordController,
                          obscureText: true,
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(20)
                          ],
                        ),
                        SizedBox(height: 30),
                        Text(
                          'Confirmed Password',
                          style: TextStyle(
                              fontSize: 15,
                              color: HexColor.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        PlatformTextField(
                          focusNode: _confirmPasswordFocusNode,
                          onSubmitted: (_) {
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          controller: _confirmPasswordController,
                          obscureText: true,
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(20)
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  ButtonTheme(
                    minWidth:
                        (deviceData.size.width - deviceData.padding.bottom) *
                            0.6,
                    height: 40,
                    child: RaisedButton(
                      color: HexColor.primaryColor,
                      onPressed: () async {
                        if (_oldPasswordController.text.isEmpty) {
                          return flutterShowToast('Please insert old password');
                        } else if (_newPasswordController.text.isEmpty) {
                          return flutterShowToast('Please insert new password');
                        } else if (_confirmPasswordController.text.isEmpty) {
                          return flutterShowToast(
                              'Please insert confirm password');
                        } else if (_newPasswordController.text !=
                            _confirmPasswordController.text) {
                          return flutterShowToast(
                              'New password not match with confirm password');
                        } else if(_oldPasswordController.text == _newPasswordController.text) {
                          return flutterShowToast('New password cannot same with old password');
                        }

                        try {
                          setState(() {
                            _isLoading = true;
                          });

                          await Provider.of<Profile>(context, listen: false)
                              .updatePassword(
                            _oldPasswordController.text,
                            _newPasswordController.text,
                          );

                          flutterShowToast('Password Update Successful');

                          return Future.delayed(Duration(milliseconds: 200),
                              () {
                            Navigator.of(context).pop();
                          });
                        } catch (err) {
                          showPlatformDialog(
                            context: context,
                            builder: (ctx) => PlatformAlertDialog(
                              content: Text(err.toString()),
                              title: Text('Error Occur'),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Ok'),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ],
                            ),
                          );
                        } finally {
                          setState(() {
                            _isLoading = false;
                            _oldPasswordController.text = '';
                            _newPasswordController.text = '';
                            _confirmPasswordController.text = '';
                          });
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        'Update Password',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
