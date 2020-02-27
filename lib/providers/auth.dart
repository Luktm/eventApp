import 'dart:convert';
import 'dart:core';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token;
  String _uid;
  String _status;
  String _message;
  String _id;
  String _table;
  String _mobile;
  String _email;
  String _luckyNo;

  DateTime _expiryDate;

  static String _apiBaseUrl = 'http://192.168.0.199:8000';

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }

    return null;
  }

  String get apiBaseUrl {
    return _apiBaseUrl;
  }

  Future<void> login(String email, String password) async {
    print('login functino');
    // var url = '$_apiBaseUrl/api/login?email=$email&password=$password';

    // try {
    //   final response = await http.get(url, headers: {"Content-type": 'application/json'});

    //   print({response.body});
    // } catch (err) {
    //   throw err;
    // }
  }
}
