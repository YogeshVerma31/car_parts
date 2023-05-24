import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  late SharedPreferences sharedPreference;

  factory SharedPreference() {
    return _instance;
  }

  SharedPreference._internal();

  static final SharedPreference _instance = SharedPreference._internal();

  Future<void> init() async {
    sharedPreference = await SharedPreferences.getInstance();
  }

  void putString(String key, String value) async {
    await sharedPreference.setString(key, value);
  }

  getString(String key) {
    return sharedPreference.getString(key);
  }

  void putInt(String key, int value) {
    sharedPreference.setInt(key, value);
  }

  // static Future<void> getInt(String key) {
  //   return sharedPreference.read(key);
  // }

  void putBool(String key, bool value) {
    sharedPreference.setBool(key, value);
  }

  // static Future<void> getBool(String key) {
  //   return sharedPreference.read(key);
  // }

  void putDouble(String key, double value) {
    sharedPreference.setDouble(key, value);
  }

  // static Future<void> getDouble(String key) {
  //   return sharedPreference.read(key);
  // }

  void remove() {
    sharedPreference.clear();
  }
}
