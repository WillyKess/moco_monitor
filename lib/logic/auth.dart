import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get_it/get_it.dart';
import 'package:moco_monitor/logic/data.dart';
import 'package:moco_monitor/logic/storage.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:studentvueclient/studentvueclient.dart';

Future<String?> authUser(LoginData data) async {
  String username = data.name;
  String password = data.password;
  Prefs prefs = GetIt.instance<Prefs>();
  debugPrint('Student ID: $username, Password: $password');
  debugPrint(prefs.get("Username"));
  debugPrint(prefs.prefsMap.keys.join());
  debugPrint(prefs.prefsMap.values.join(', '));

  if (await isValid(username, password)) {
    prefs.setSaveSecure("Username", username);
    prefs.setSaveSecure("Password", password);
    return null;
  } else {
    return Future.value("Invalid Credentials :(");
  }
}

Future<bool> isValid(String username, String password) async {
  var data = await StudentVueClient(
          username, password, "md-mcps-psv.edupoint.com", true, false)
      .loadGradebook();
  bool valid = data.studentName != null;
  if (valid) {
    GetIt.instance<Data>().data = data;
  }
  // GetIt.instance<Prefs>().hasValidCredentials = valid;
  GetIt.instance<Prefs>().hasValidCredentials = true;
  // return valid;
  return true;
}
