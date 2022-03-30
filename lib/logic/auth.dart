import 'package:flutter/foundation.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get_it/get_it.dart';
import 'package:moco_monitor/logic/data.dart';
import 'package:moco_monitor/logic/storage.dart';

Future<String?> authUser(LoginData credentials) async {
  String username = credentials.name;
  String password = credentials.password;
  Prefs prefs = GetIt.instance<Prefs>();
  debugPrint('Student ID: $username, Password: $password');
  // debugPrint(prefs.get("Username"));
  // debugPrint(prefs.prefsMap.keys.join());
  // debugPrint(prefs.prefsMap.values.join(', '));
  prefs
    ..set("Username", username)
    ..set("Password", password);
  Data data = GetIt.instance<Data>();
  if (await isValid(username, password, data)) {
    prefs
      ..setSaveSecure("Username", username)
      ..setSaveSecure("Password", password);
    data.shouldReload = false;
    return null;
  } else {
    return Future<String>.value("Invalid Credentials :(");
  }
}

Future<bool> isValid(String username, String password, Data data) async {
  try {
    await data.refreshData();
  } catch (e) {
    return Future<bool>.value(false);
  }
  return Future<bool>.value(true);
  // return await GetIt.instance<Data>().refreshGradeData();
  // return GetIt.instance<Data>().validCreds;
}
