import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:get_it/get_it.dart';
import 'package:moco_monitor/logic/data.dart';

class Prefs {
  final EncryptedSharedPreferences _secPrefs = EncryptedSharedPreferences();
  final Map<String, String> prefsMap = {};
  Prefs() {
    init();
  }
  void init() async {
    prefsMap["Username"] = await _secPrefs.getString("Username");
    prefsMap["Password"] = await _secPrefs.getString("Password");
    GetIt.instance<Data>().refreshGradeData();
  }

  void set(String key, String value) {
    prefsMap[key] = value;
  }

  void setSaveSecure(String key, String value) async {
    await _secPrefs.setString(key, value);
    prefsMap[key] = value;
  }

  String get(String key) {
    return prefsMap[key] ?? '';
  }
}
