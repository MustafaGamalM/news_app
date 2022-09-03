import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CasheHelper {
  static SharedPreferences prefs;
  static inite() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> setBoolData(
      {@required String key, @required bool value}) async {
    return await prefs.setBool(key, value);
  }

  static bool getBoolData({@required String key}) {
    return prefs.getBool(key);
  }
}
