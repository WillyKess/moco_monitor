import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:moco_monitor/business_logic/storage.dart';
import 'package:studentvueclient/studentvueclient.dart';
import '../business_logic/auth.dart';

// bool hasRun = false;
// void storage() async {
//   debugPrint("1");
//   // const FlutterSecureStorage secureStorage = FlutterSecureStorage();
//   debugPrint("2");

//   // var containsEncryptionKey = await secureStorage.containsKey(key: 'key');
//   debugPrint("3");
//   // if (!containsEncryptionKey) {
//   // var key = Hive.generateSecureKey();
//   var key = [
//     239,
//     84,
//     237,
//     234,
//     72,
//     225,
//     209,
//     230,
//     222,
//     123,
//     199,
//     24,
//     14,
//     159,
//     43,
//     186,
//     188,
//     48,
//     252,
//     26,
//     99,
//     22,
//     23,
//     252,
//     62,
//     68,
//     146,
//     203,
//     55,
//     233,
//     11,
//     86
//   ];
//   // await secureStorage.write(key: 'key', value: base64UrlEncode(key));
//   // }
//   debugPrint("4");

//   // var encryptionKey =
//   // await base64Url.decode(await secureStorage.read(key: 'key').toString());
//   // debugPrint('Encryption key: $encryptionKey');
//   debugPrint('Encryption key: $key');
//   debugPrint("5");
//   var encryptedBox = await Hive.openBox('vaultBox',
//       // encryptionCipher: HiveAesCipher(encryptionKey));
//       encryptionCipher: HiveAesCipher(key));
//   encryptedBox.put('secret', 'Hive is cool');
//   debugPrint("6");
//   debugPrint(encryptedBox.get('secret'));
//   encryptedBox.delete('secret');
//   debugPrint("7");
//   debugPrint(encryptedBox.get('secret'));
// }

class LoginScreen extends StatelessWidget {
  final EncryptedSharedPreferences credstore;

  LoginScreen({Key? key, required this.credstore}) : super(key: key);
  // final AuthLogic authDaddy = AuthLogic();
  // final EncryptedStorage storage = EncryptedStorage();

  @override
  build(BuildContext context) async {
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
    // if (!hasRun) {
    //   // authDaddy.storage();
    //   // authDaddy.storage2();
    //   storage.startBox();
    //   storage.write('test2', "Poonis");
    //   debugPrint("eee");
    //   debugPrint(storage.read('test1'));
    //   hasRun = true;
    // }

    // String getValue(String keyy) {
    //   String? tempValue = "unchanged";
    //   void setTemp(String keyy) async =>
    //       tempValue = await credstore.read(key: keyy);
    //   setTemp(keyy);
    //   debugPrint(tempValue);
    //   return tempValue.toString();
    // }

    // final inputBorder = BorderRadius.vertical(
    //   bottom: Radius.circular(10.0),
    //   top: Radius.circular(20.0),
    // );

    return FlutterLogin(
      title: "MoCo Monitor",
      onLogin: authUser,
      onRecoverPassword: (_) => Future(() => null),
      userValidator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      userType: LoginUserType.name,
      messages: LoginMessages(userHint: "123456", passwordHint: "Abcd1234"),
      savedEmail: await credstore.getString("Student ID"),
    );
  }
}
