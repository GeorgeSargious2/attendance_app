import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  // private constructor as I don't want to allow creating an instance of this class itself.
  SharedPrefHelper._();

  static final _secureStorage = FlutterSecureStorage();
  static SharedPreferences? _sharedPreferences;

  // Initialize SharedPreferences instance
  static Future<void> init() async {
    // Added init method
    _sharedPreferences = await SharedPreferences.getInstance();
    log('SharedPrefHelper Initialized');
  }

  static SharedPreferences get _prefs {
    // Made getter synchronous after init
    if (_sharedPreferences == null) {
      throw Exception("SharedPrefHelper not initialized. Call init() first.");
    }
    return _sharedPreferences!;
  }

  /// Removes a value from SharedPreferences with given [key].
  static Future<bool> removeData(String key) async {
    log('SharedPrefHelper : data with key : $key has been removed');
    return _prefs.remove(key);
  }

  /// Removes all keys and values in the SharedPreferences
  static Future<bool> clearAllData() async {
    log('SharedPrefHelper : all data has been cleared');
    return _prefs.clear();
  }

  /// Saves a [value] with a [key] in the SharedPreferences.
  static Future<void> setData(String key, dynamic value) async {
    log("SharedPrefHelper : setData with key : $key and value : $value"); // Log value too

    try {
      if (value is String) {
        await _prefs.setString(key, value);
      } else if (value is int) {
        await _prefs.setInt(key, value);
      } else if (value is bool) {
        await _prefs.setBool(key, value);
      } else if (value is double) {
        await _prefs.setDouble(key, value);
      } else if (value is List<String>) {
        await _prefs.setStringList(key, value);
      } else {
        log("Unsupported type for SharedPreferences: ${value.runtimeType}");
      }
    } catch (e) {
      log("Error setting data in SharedPreferences: $e");
    }
  }

  /// Gets a bool value from SharedPreferences with given [key]. Defaults to false.
  static bool getBool(String key) {
    log('SharedPrefHelper : getBool with key : $key');
    try {
      return _prefs.getBool(key) ?? false;
    } catch (e) {
      log("Error getting bool for key $key: $e");
      return false;
    }
  }

  /// Gets a double value from SharedPreferences with given [key]. Defaults to 0.0.
  static double getDouble(String key) {
    log('SharedPrefHelper : getDouble with key : $key');
    try {
      return _prefs.getDouble(key) ?? 0.0;
    } catch (e) {
      log("Error getting double for key $key: $e");
      return 0.0;
    }
  }

  /// Gets an int value from SharedPreferences with given [key]. Defaults to 0.
  static int getInt(String key) {
    log('SharedPrefHelper : getInt with key : $key');
    try {
      return _prefs.getInt(key) ?? 0;
    } catch (e) {
      log("Error getting int for key $key: $e");
      return 0;
    }
  }

  /// Gets an String value from SharedPreferences with given [key]. Defaults to ''.
  static String getString(String key) {
    log('SharedPrefHelper : getString with key : $key');
    try {
      return _prefs.getString(key) ?? '';
    } catch (e) {
      log("Error getting string for key $key: $e");
      return '';
    }
  }

  //// Gets an StringList value from SharedPreferences with given [key]. Defaults to [].
  static List<String> getStringList(String key) {
    log('SharedPrefHelper : getStringList with key : $key');
    try {
      return _prefs.getStringList(key) ?? [];
    } catch (e) {
      log("Error getting string list for key $key: $e");
      return [];
    }
  }

  /// Saves a [value] with a [key] in the FlutterSecureStorage.
  static Future<void> setSecuredString(String key, String value) async {
    log("FlutterSecureStorage : setSecuredString with key : $key and value : $value"); // Log value
    try {
      await _secureStorage.write(key: key, value: value);
    } catch (e) {
      log("Error setting secured string for key $key: $e");
    }
  }

  /// Gets an String value from FlutterSecureStorage with given [key]. Defaults to ''.
  static Future<String> getSecuredString(String key) async {
    log('FlutterSecureStorage : getSecuredString with key : $key');
    try {
      return await _secureStorage.read(key: key) ?? '';
    } catch (e) {
      log("Error getting secured string for key $key: $e");
      return '';
    }
  }

  /// Removes all keys and values in the FlutterSecureStorage
  static Future<void> clearAllSecuredData() async {
    log('FlutterSecureStorage : all data has been cleared');
    try {
      await _secureStorage.deleteAll();
    } catch (e) {
      log("Error clearing secured data: $e");
    }
  }

  /// Deletes a specific key from FlutterSecureStorage
  static Future<void> removeSecuredData(String key) async {
    log('FlutterSecureStorage : removeSecuredData with key : $key');
    try {
      await _secureStorage.delete(key: key);
    } catch (e) {
      log("Error removing secured data for key $key: $e");
    }
  }
}
