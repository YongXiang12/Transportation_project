import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static final SharedPreferencesUtil instance = new SharedPreferencesUtil();
  SharedPreferences?sp;

  static getInstance() {
    return instance;
  }

  Future<dynamic> setString(String key, String value) async {
    sp = await SharedPreferences.getInstance();
    return sp?.setString(key, value);
  }

  Future<dynamic> setBool(String key, bool value) async {
    sp = await SharedPreferences.getInstance();
    return sp?.setBool(key, value);
  }

  Future<dynamic> setDouble(String key, double value) async {
    sp = await SharedPreferences.getInstance();
    return sp?.setDouble(key, value);
  }

  Future<dynamic> setInt(String key, int value) async {
    sp = await SharedPreferences.getInstance();
    return sp?.setInt(key, value);
  }

  Future<dynamic> setStringList(String key, List<String> value) async {
    sp = await SharedPreferences.getInstance();
    return sp?.setStringList(key, value);
  }

  Future<dynamic> getString(String key) async {
    sp = await SharedPreferences.getInstance();
    return sp?.getString(key);
  }

  Future<dynamic> getBool(String key) async {
    sp = await SharedPreferences.getInstance();
    return sp?.getBool(key);
  }

  Future<dynamic> getDouble(String key) async {
    sp = await SharedPreferences.getInstance();
    return sp?.getDouble(key);
  }

  Future<dynamic> getInt(String key) async {
    sp = await SharedPreferences.getInstance();
    return sp?.getInt(key);
  }

  Future<dynamic> getStringList(String key) async {
    sp = await SharedPreferences.getInstance();
    return sp?.getStringList(key);
  }

  Future<dynamic> getKeys() async {
    sp = await SharedPreferences.getInstance();
    return sp?.getKeys();
  }
}
