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
    Future<String> safeGet(String key) async {
      try {
        return _secPrefs.getString(key);
      } catch (e) {
        return Future<String>.value('');
      }
    }

    prefsMap["Username"] = await safeGet('Username');
    prefsMap["Password"] = await safeGet('Password');

    try {
      GetIt.instance<Data>().refreshGradeData();
      // ignore: empty_catches
    } catch (e) {}
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
