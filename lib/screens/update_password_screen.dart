import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../helpers/hex_color.dart';

import '../widgets/safe_area_widget.dart';

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

  void flutterShowToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
    );
  }

  void updatePassword() {
    if (_oldPasswordController.text.isEmpty) {
      return flutterShowToast('Please insert old password');
    } else if (_newPasswordController.text.isEmpty) {
      return flutterShowToast('Please insert new password');
    } else if (_confirmPasswordController.text.isEmpty) {
      return flutterShowToast('Please insert confirm password');
    } else if (_newPasswordController.text != _confirmPasswordController.text) {
      return flutterShowToast('New password not match with confirm password');
    }

    print('can proceed');
  }

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    return PlatformScaffold(
      backgroundColor: Colors.white,
      appBar: PlatformAppBar(
        title: Text('Reset Password'),
      ),
      body: SafeAreaWidget(
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
                      (deviceData.size.width - deviceData.padding.bottom) * 0.6,
                  height: 40,
                  child: RaisedButton(
                    color: HexColor.primaryColor,
                    onPressed: () => updatePassword(),
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
    );
  }
}
