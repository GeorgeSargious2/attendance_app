import 'package:shared_preferences/shared_preferences.dart';

class cacheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putData({
    required String key,
    required bool value,
  }) async {
    return await sharedPreferences.setBool(key, value);
  }

  static dynamic getData({
    required String key,
  }) {
    return sharedPreferences.get(key);
  }

  static Future<bool> SaveData({
    required String key,
    required dynamic value,
  }) async {
    if (value == null) {
      return await sharedPreferences.setString(key, value);
    } else if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else if (value is double) {
      return await sharedPreferences.setDouble(key, value);
    } else {
      // Handle other data types or throw an error if unsupported
      print(
          "Unsupported data type for SharedPreferences: ${value.runtimeType}");
      return false;
    }
  }

  static Future<bool> RemoveData({required String key}) async {
    return await sharedPreferences.remove(key);
  }
}
