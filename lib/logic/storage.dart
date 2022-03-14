import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  late final EncryptedSharedPreferences _secPrefs;
  late final SharedPreferences _prefs;
  final Map<String, String> prefsMap = {};
  bool hasValidCredentials = false;
  Future<bool> init() async {
    _prefs = await SharedPreferences.getInstance();
    _secPrefs = EncryptedSharedPreferences();
    if (_secPrefs.prefs?.getKeys() != null) {
      for (String value in _secPrefs.prefs!.getKeys()) {
        print(value + "errrt");
        prefsMap[value] = await _secPrefs.getString(value);
        print(await _secPrefs.getString(value) + "eeeee");
      }
    }
    // for (String value in _prefs.getKeys()) {
    //   if (_prefs.getString(value) != null) {
    //     prefsMap[value] = _prefs.getString(value)!;
    //   }
    // }
    return true;
  }

  void set(String key, String value) {
    prefsMap[key] = value;
  }

  void setSave(String key, String value) async {
    await _prefs.setString(key, value);
    prefsMap[key] = value;
  }

  void setSaveSecure(String key, String value) async {
    await _secPrefs.setString(key, value);
    prefsMap[key] = value;
  }

  String get(String key) {
    return prefsMap[key] ?? 'rrr';
  }
}
