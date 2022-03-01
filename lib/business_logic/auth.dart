// import 'dart:io';

import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:studentvueclient/studentvueclient.dart';

class AuthLogic {
  void storage() async {
    debugPrint("1");
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    debugPrint("2");

    var containsEncryptionKey = await secureStorage.containsKey(key: 'key');
    debugPrint("3");
    if (!containsEncryptionKey) {
      var key = Hive.generateSecureKey();
      await secureStorage.write(key: 'key', value: base64UrlEncode(key));
    }
    debugPrint("4");
    String? eek = await secureStorage.read(key: 'key');
    debugPrint(eek);
    var encryptionKey = base64Decode(eek!);
    // base64Url.decode(secureStorage.read(key: 'key').toString());
    debugPrint('Encryption key: $encryptionKey');
    debugPrint("5");
    // debugPrint('Encryption key: $key');
    var encryptedBox = await Hive.openBox('vaulty',
        encryptionCipher: HiveAesCipher(encryptionKey));
    // encryptionCipher: HiveAesCipher(key));
    // encryptedBox.clear();
    encryptedBox.put('secret', 'Hive is cool');
    debugPrint("6");
    debugPrint(encryptedBox.get('secret'));
    debugPrint("7");
  }

  // FlutterSecureStorage credstore = const FlutterSecureStorage();
  // EncryptedSharedPreferences credstore = EncryptedSharedPreferences();
// users.write({key = "will", value = "1029"});
// bool validCredentials(String username, String password) {
//   final svClient = StudentVueClient(
//       username, password, "md-mcps-psv.edupoint.com", false, true);
//   // if (svClient.loadStudentData() != null) {
//   //   credstore.write(key: username, value: username);
//   //   credstore.write(key: password, value: password);
//   //   return Future.value(true);
//   // } else {
//   //   return Future.value(false);
//   // }
//   debugPrint(await svClient.loadGradebook().classes!;
//   return (svClient.loadStudentData().toString().isNotEmpty);
// }
  String getValue(String keyy) {
    // String? tempValue;
    widget.credstore.getString(keyy).then((value) {
      return value;
    });
    return "";

    // setTemp(keyy);
    // sleep(const Duration(seconds: 2));
    // setTemp(keyy);
    // debugPrint(tempValue);
    // return tempValue.toString();
  }

  Future<String?> authUser(LoginData data) async {
    String username = data.name;
    String password = data.password;
    debugPrint('Student ID: $username, Password: $password');
    isValid(String username, String password) async {
      var studentGender = (await StudentVueClient(
                  username, password, "md-mcps-psv.edupoint.com", true, false)
              .loadStudentData())
          .gender;
      // var d = await s.loadStudentData();
      // debugPrint(d.classes.toString());
      // debugPrint(d.gender);
      // debugPrint(d.studentName);

      return (studentGender != null);
    }

    if (await isValid(username, password)) {
      // credstore.write(key: "StudentID", value: username);
      // credstore.write(key: "Password", value: password);
      credstore.setString("Student ID", username);
      credstore.setString("Password", password);

      return null;
    } else {
      return Future.value("Invalid Credentials :(");
    }
  }
  // ? "Valid Credentials!" : "Invalid Credentials :(";

  // return returner(username, password);

  // if (validCredentials(username, password)) {
  //   credstore.write(key: username, value: username);
  //   credstore.write(key: password, value: password);
  //   return Future.value("Success!");
  // } else {
  //   return Future.value("Invalid Credentials");
  // }
  // return Future.delayed(loginTime).then((_) async {
  //   if (!(await users.containsKey(key: data.name))) {
  //     return 'User does not exist';
  //   }
  //   if (await users.read(key: data.name) != data.password) {
  //     return 'Password does not match';
  //   }
  //   return null;
  // });
}
