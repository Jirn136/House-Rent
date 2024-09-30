import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  final SharedPreferences _prefs;

  SharedPrefs(this._prefs);

  Future<void> save(String key, dynamic value) async {
    switch (value) {
      case String():
        await _prefs.setString(key, value);
      case int():
        await _prefs.setInt(key, value);
      case double():
        await _prefs.setDouble(key, value);
      case bool():
        await _prefs.setBool(key, value);
      default:
        await _prefs.setStringList(key, value);
    }
  }

  String getString(String key) => _prefs.getString(key) ?? '';

  bool getBoolean(String key) => _prefs.getBool(key) ?? false;

  int getInt(String key) => _prefs.getInt(key) ?? 0;

  double getDouble(String key) => _prefs.getDouble(key) ?? 0;

  List<String> getStringList(String key) => _prefs.getStringList(key) ?? [];
}
