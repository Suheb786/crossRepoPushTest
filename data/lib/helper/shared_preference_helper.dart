import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  SharedPreferenceHelper._();

  static const String IS_FIRST_RUN = "first_run";
  static const String WALLET_ID = "walletId";

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

  ///wallet id set
  static Future<bool> saveWalletId({String? walletId}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(WALLET_ID, walletId ?? '');
  }

  ///get wallet id
  static Future<String?> getWalletId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(WALLET_ID);
  }

  ///clear wallet id
  static Future<bool> clearWalletId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(WALLET_ID);
  }
}
