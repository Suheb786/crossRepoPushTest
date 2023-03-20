import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  SharedPreferenceHelper._();

  static const String IS_FIRST_RUN = "first_run";

  static Future<bool> saveValue(bool setValue) async {
    final prefs = await SharedPreferences.getInstance();
    var value = await prefs.setBool(IS_FIRST_RUN, setValue);
    return value;
  }

  static Future<bool> getValue() async {
    final prefs = await SharedPreferences.getInstance();
    var value = await prefs.getBool(IS_FIRST_RUN);
    return value ?? true;
  }

  static Future<bool> clearUserValue() async {
    final prefs = await SharedPreferences.getInstance();
    var value = await prefs.clear();
    return value;
  }
}
