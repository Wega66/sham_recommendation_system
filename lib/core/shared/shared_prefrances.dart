import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  //! Singleton pattern to avoid creating multiple instances
  static final SharedPreferencesHelper instance =
      SharedPreferencesHelper._internal();
  factory SharedPreferencesHelper() => instance;
  SharedPreferencesHelper._internal();

  //! Method to save a string value
  static Future<bool> saveString(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  //! Method to get a string value
  static Future<String?> getString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  //! Method to save an integer value
  static Future<bool> saveInt(String key, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(key, value);
  }

  //! Method to get an integer value
  static Future<int?> getInt(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  //! Method to save a boolean value
  static Future<bool> saveBool(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }

  //! Method to get a boolean value
  static Future<bool?> getBool(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  //! Method to save a double value
  static Future<bool> saveDouble(String key, double value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setDouble(key, value);
  }

  //! Method to get a double value
  static Future<double?> getDouble(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }

  //! Method to save a list of strings
  static Future<bool> saveStringList(String key, List<String> value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(key, value);
  }

  //! Method to get a list of strings
  static Future<List<String>?> getStringList(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key);
  }

  //! Method to remove a specific key
  static Future<bool> remove(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  //! Method to check if a key exists
  static Future<bool> containsKey(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  //! Method to clear all SharedPreferences data
  static Future<bool> clear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}
