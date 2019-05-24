import 'package:shared_preferences/shared_preferences.dart';

class Sp {
  static put(String key, String value) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static getS(String key, Function callback) async {
    SharedPreferences.getInstance().then((prefs) {
      callback(prefs.getString(key));
    });
  }

  static getSAsync(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}

class SpConsKy {
  static String key_username = "username";
  static String key_password = "password";
  static String key_email = "email";
  static String key_cookie_expires = "expires";
  static String key_cookie = "cookie";
  static String key_theme = "theme";
  static String key_language = "language";
}
