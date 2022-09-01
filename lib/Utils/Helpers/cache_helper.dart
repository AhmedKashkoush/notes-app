import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsApi {
  static late SharedPreferences _prefs;
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static void setInt(String key, int value) => _prefs.setInt(key, value);
  static void setDouble(String key, double value) =>
      _prefs.setDouble(key, value);
  static void setString(String key, String value) =>
      _prefs.setString(key, value);
  static void setBool(String key, bool value) => _prefs.setBool(key, value);

  static int? getInt(String key) => _prefs.getInt(key);
  static double? getDouble(String key) => _prefs.getDouble(key);
  static String? getString(String key) => _prefs.getString(key);
  static bool? getBool(String key) => _prefs.getBool(key);
}
