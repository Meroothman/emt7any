import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Save String
  static Future<bool> saveString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  // Get String
  static String? getString(String key) {
    return _prefs.getString(key);
  }

  // Save Bool
  static Future<bool> saveBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  // Get Bool
  static bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  // Save Int
  static Future<bool> saveInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  // Get Int
  static int? getInt(String key) {
    return _prefs.getInt(key);
  }

  // Save JSON Object
  static Future<bool> saveJson(String key, Map<String, dynamic> json) async {
    final jsonString = jsonEncode(json);
    return await saveString(key, jsonString);
  }

  // Get JSON Object
  static Map<String, dynamic>? getJson(String key) {
    final jsonString = getString(key);
    if (jsonString == null) return null;
    return jsonDecode(jsonString) as Map<String, dynamic>;
  }

  // Save JSON List
  static Future<bool> saveJsonList(String key, List<dynamic> list) async {
    final jsonString = jsonEncode(list);
    return await saveString(key, jsonString);
  }

  // Get JSON List
  static List<dynamic>? getJsonList(String key) {
    final jsonString = getString(key);
    if (jsonString == null) return null;
    return jsonDecode(jsonString) as List<dynamic>;
  }

  // Remove Data
  static Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  // Clear All Data
  static Future<bool> clearAll() async {
    return await _prefs.clear();
  }

  // Check if key exists
  static bool containsKey(String key) {
    return _prefs.containsKey(key);
  }
}