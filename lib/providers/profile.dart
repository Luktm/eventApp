import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../providers/auth.dart';

class Profile with ChangeNotifier {
  final String email;
  final String baseUrl;

  Profile(this.email, this.baseUrl);

  // void flutterShowToast(String msg) {
  //   Fluttertoast.showToast(
  //     msg: msg,
  //     toastLength: Toast.LENGTH_SHORT,
  //     gravity: ToastGravity.TOP,
  //   );
  // }

  Future<void> updatePassword(oldPassword, newPassword) async {
    try {
      var url = "$baseUrl/changepassword";
      print(url);

      final response = await http.post(
        url,
        // headers: {"Content-type": 'application/json'},
        body: {
          "email": email,
          "oldpassword": oldPassword,
          "newpassword": newPassword
        },
      );

      print(response.statusCode);
      // print('abcdefghijklmn');

      if (response.statusCode >= 300 && response.statusCode < 400) {
        throw 'Redirection Error';
      }

      if(response.statusCode >=400 && response.statusCode < 500) {
        throw 'Client Error';
      }

      if(response.statusCode >=500) {
        throw 'Server Error';
      }

      final responseData = response.body;

      print({"responseData"});

      // final responseData = json.decode(response.body);

      if (responseData ==
          'Your old password does not match with your current password.') {
        throw responseData;
      }

      // flutterShowToast('Password Update Successful');

      // return Future.delayed(Duration(milliseconds: 200), () {
      //   Navigator.of(context).pop();
      // });

    } on SocketException catch (err) {
      throw({"socket problem": err});
    } catch (err) {
      throw err.toString();

      // showPlatformDialog(
      //   context: context,
      //   builder: (ctx) => PlatformAlertDialog(
      //     content: Text(err.toString()),
      //     title: Text('Error Occur'),
      //     actions: <Widget>[
      //       FlatButton(
      //         child: Text('Ok'),
      //         onPressed: () => Navigator.of(context).pop(),
      //       ),
      //     ],
      //   ),
      // );
    }
  }
}
