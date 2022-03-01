import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

class EncryptedStorage {
  late Box<String> box;
  Future<bool> encryptionKey() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    var containsEncryptionKey = await secureStorage.containsKey(key: 'key');
    if (!containsEncryptionKey) {
      var key = Hive.generateSecureKey();
      await secureStorage.write(key: 'key', value: base64UrlEncode(key));
    }
    String? eek = await secureStorage.read(key: 'key');
    // return base64Decode(eek!);
    box = await Hive.openBox('vaultessini',
        encryptionCipher: HiveAesCipher(base64Decode(eek!)));
    return true;
    // return await Hive.openBox('vaulty',
    //     encryptionCipher: HiveAesCipher(encryptionKey));
  }

  bool startBox() {
    bool boxExists = false;
    encryptionKey()
        .then((value) => boxExists = value ? true : false)
        .whenComplete(() => (boxExists = true));
    Timer.periodic(const Duration(seconds: 1), (timer) {});
    // while (!boxExists) {}
    return boxExists;
    // if (boxExists) {
    //   return;
    // }
    // while(){

    // }
    // sleep(const Duration(seconds: 5));
  }

  String read(String key) {
    // String returnValue = "unset";
    // Future<String> getValue(String key) async {
    // var box = await Hive.openBox('vaultessa',
    //     encryptionCipher: HiveAesCipher(await encryptionKey()));
    // box.put('secret', 'Hive is cool');
    return (box.get(key).toString());
    // returnValue = box.get(key);
    // return true;
    // }

    // var getValueIsFinished = false;
    // getValue(key).then((value) => returnValue = value);
    // return returnValue;
    // return "eeeoo";
    // String valuee = "rtr";
    // debugPrint(valuee);
    // getValue(key).then((value) {
    //   debugPrint(value);
    //   valuee = value;
    //   return value;
    // });
    // debugPrint(valuee);

    // return valuee;
  }

  void write(String key, String value) {
    // initBox() async {
    //   var box = await Hive.openBox('vaultessa',
    //       encryptionCipher: HiveAesCipher(await encryptionKey()));
    // }
    //   box.put(key, value);
    // }

    // void isWritten() {
    // saveButton.enabled = false;
    //   writer(key, value)
    //       .then((success) => debugPrint(success ? 'Saved' : 'Failed'))
    //       .catchError((e) => debugPrint(e));
    //   // .whenComplete(() { saveButton.enabled = true; });
    //   // }
    // }

    // Future<bool> writer(String key, String value) async {
    //   // save changes async here
    //   // var box = await Hive.openBox('vaultessini',
    //   //     encryptionCipher: HiveAesCipher(await encryptionKey()));
    box.put(key, value);
    //   return true;
    // }
  }
}
