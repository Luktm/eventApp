import 'dart:convert';
import 'dart:core';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token;
  String _uid;
  String _status;
  String _message;
  int _id;
  int _table;
  String _mobile;
  String _email;
  String _lucky;
  String _name;
  String _profileImage;

  Timer _authTimer;
  DateTime _expiryDate;

  bool _firstTimeLogin = true;

  static String _apiBaseUrl = 'https://cems.jnghng.com/api';
  // static String _apiBaseUrl = 'http://192.168.68.116:8000/api';

  bool get isAuth {
    // return token != null;

    // for no token purpose
    return _mobile != null;
  }

  String get name {
    return _name;
  }

  String get token {
    // if (_expiryDate != null &&
    //     _expiryDate.isAfter(DateTime.now()) &&
    //     _token != null) {
    //   return _token;
    // }

    return null;
  }

  String get apiBaseUrl {
    return _apiBaseUrl;
  }

  String get lucky {
    return _lucky;
  }

  int get id {
    return _id;
  }

  String get mobile {
    return _mobile;
  }

  int get table {
    return _table;
  }

  bool get firstTimeLogin {
    return _firstTimeLogin;
  }

  String get status {
    return _status;
  }

  String get email {
    return _email;
  }
  
  String get profileImage {
    return _profileImage;
  }

  Future<void> login(String email, String password) async {
    print('login functino');
    var url = '$_apiBaseUrl/login?email=$email&password=$password';

    print({'url': url});

    try {
      final response = await http.get(url, headers: {"Content-type": 'application/json'});

      final responseData = json.decode(response.body);

      if (responseData['status'] == 'fail') {
        throw (responseData['message']);
      }

      _status = responseData['status'];
      _message = responseData['message'];
      _id = responseData['id'];
      _table = responseData['table'];
      _mobile = responseData['mobile'];
      _email = responseData['email'];
      _lucky = responseData['lucky'];
      _name = responseData['name'];
      // _token = responseData['token'];

      // _expiryDate = DateTime.now().add(Duration(seconds: int.parse(responseData['expiresIn'])));

      final prefs = await SharedPreferences.getInstance();

      if (prefs.containsKey('firstTimeLogin')) {
        _firstTimeLogin = prefs.getBool('firstTimeLogin');
      }

      notifyListeners();
      print('abc');

      final userData = json.encode(
        {
          "status": _status,
          'message': _message,
          'id': _id,
          'table': _table,
          'mobile': _mobile,
          'email': _email,
          'lucky': _lucky,
          'name': _name
        },
      );

      prefs.setString('userData', userData);
    } catch (err) {
      throw err;
    }
  }

  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('userData')) {
      return false;
    }

    if (prefs.containsKey('firstTimeLogin')) {
      _firstTimeLogin = prefs.getBool('firstTimeLogin');
    }

    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;

    // final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

    // if(expiryDate.isBefore(DateTime.now())) {
    //   return false;
    // }

    _status = extractedUserData['status'];
    _message = extractedUserData['message'];
    _id = extractedUserData['id'];
    _table = extractedUserData['table'];
    _mobile = extractedUserData['mobile'];
    _email = extractedUserData['email'];
    _lucky = extractedUserData['lucky'];
    _name = extractedUserData['name'];
    // _token = extractedUserData['token'];
    // _expiryDate = expiryDate;

    notifyListeners();
    // _autoLogout();
    return true;
  }

  Future<void> firstTimeLoginMethod() async {
    _firstTimeLogin = false;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('firstTimeLogin', false);

    notifyListeners();
  }

  Future<void> logout() async {
    // _token = null;
    // _uid = null;
    // _expiryDate = null;
    _mobile = null;

    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }

    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData'); // <= if got more instance key
    // prefs.clear();
  }

  int _increment = 0;

  Future<void> profileKeepFetch() async {
    var url = "$apiBaseUrl/status?id=$_id";

    try {
      final response = await http.get(url);

      final responseData = json.decode(response.body);

      _status = responseData['status'];
      _message = responseData['message'];
      _id = responseData['id'];
      _table = responseData['table'];
      _mobile = responseData['mobile'];
      _email = responseData['email'];
      _lucky = responseData['lucky'];
      _name = responseData['name'];

      // print(_name);

      notifyListeners();

      // final prefs = await SharedPreferences.getInstance();

      // if (prefs.containsKey('userData')) {
      //   prefs.remove('userData'); // <= if got more instance key
      // }

      // final userData = json.encode({
      //   "status": _status,
      //   "message": _message,
      //   'id': _id,
      //   'table': _table,
      //   'mobile': _mobile,
      //   'email': _email,
      //   'lucky': _lucky
      // });

      // prefs.setString('userData', userData);

    } catch (err) {
      throw err;
    }
  }

  // Future<void> _autoLogout() {
  //   if (_authTimer != null) {
  //     _authTimer.cancel();
  //     _authTimer = null;
  //   }

  //   final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;

  //   _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  // }
}
