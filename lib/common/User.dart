import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:wan_android_demo/api/HttpService.dart';
import 'package:wan_android_demo/common/Sp.dart';
import 'package:wan_android_demo/model/login/UserModel.dart';
import 'package:wan_android_demo/utils/DateUtil.dart';


class User {
  String userName;
  String password;
  String email;
  String cookie;
  DateTime cookieExpiresTime;
  Map<String, String> _headerMap;

  static final User _singleton = User._internal();

  factory User() {
    return _singleton;
  }

  User._internal();

  bool isLogin() {
    return null != userName &&
        userName.length >= 6 &&
        null != password &&
        password.length >= 6;
  }

  void logout() {
    Sp.put(SpConsKy.key_username,null);
    Sp.put(SpConsKy.key_password,null);
    Sp.put(SpConsKy.key_email,null);
    Sp.put(SpConsKy.key_cookie,null);
    Sp.put(SpConsKy.key_cookie_expires,null);

    cookie = null;
    userName = null;
    password = null;
    email = null;
    _headerMap = null;
  }

  void refreshUserData({Function callback}) {
    Sp.getS(SpConsKy.key_password,(pw) {
      this.password = pw;
    });
    Sp.getS(SpConsKy.key_username,(str) {
      this.userName = str;
      if (null != callback) {
        callback();
      }
    });
    Sp.getS(SpConsKy.key_cookie,(str) {
      this.cookie = str;
      _headerMap = null;
    });
    Sp.getS(SpConsKy.key_email,(str) {
      this.email = str;
    });
    Sp.getS(SpConsKy.key_cookie_expires,(str) {
      if (null != str && str.length > 0) {
        this.cookieExpiresTime = DateTime.parse(str);
        //提前3天请求新的cookie
        if (cookieExpiresTime.isAfter(DateUtil.getDaysAgo(3))) {
          Timer(Duration(milliseconds: 100), () {
            autoLogin();
          });
        }
      }
    });
  }

  void login({Function callback}) {
    _saveUserInfo(HttpService().login(userName, password), userName, password,
        callback: callback);
  }

  void register({Function callback}) {
    _saveUserInfo(
        HttpService().register(userName, password), userName, password,
        callback: callback);
  }

  void _saveUserInfo(
      Future<Response> responseF, String userName, String password,
      {Function callback}) {
    responseF.then((response) {
      var userModel = UserModel.fromJson(response.data);
      if (userModel.errorCode == 0) {
        Sp.put(SpConsKy.key_username,userName);
        Sp.put(SpConsKy.key_password,password);
        Sp.put(SpConsKy.key_email,userModel.data.email);
        this.userName = userName;
        this.password = password;
        this.email = userModel.data.email;
        String cookie = "";
        DateTime expires;
        response.headers.forEach((String name, List<String> values) {
          if (name == "set-cookie") {
            cookie = json
                .encode(values)
                .replaceAll("\[\"", "")
                .replaceAll("\"\]", "")
                .replaceAll("\",\"", "; ");
            try {
              expires = DateUtil.formatExpiresTime(cookie);
            } catch (e) {
              expires = DateTime.now();
            }
          }
        });
        this.cookie = cookie;
        _headerMap = null;
        Sp.put(SpConsKy.key_cookie,cookie);
        Sp.put(SpConsKy.key_cookie_expires,expires.toIso8601String());
        if (null != callback) callback(true, null);
      } else {
        if (null != callback) callback(false, userModel.errorMsg);
      }
    });
  }

  void autoLogin() {
    if (isLogin()) {
      login();
    }
  }

  Map<String, String> getHeader() {
    if (null == _headerMap) {
      _headerMap = Map();
      _headerMap["Cookie"] = cookie;
    }
    return _headerMap;
  }
}
