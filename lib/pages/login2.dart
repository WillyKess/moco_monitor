import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:studentvueclient/studentvueclient.dart';

class LoginScreen extends StatelessWidget {
  final EncryptedSharedPreferences credstore;
  const LoginScreen({Key? key, required this.credstore}) : super(key: key);

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
        return (studentGender != null);
      }

      if (await isValid(username, password)) {
        credstore.setString("Student ID", username);
        credstore.setString("Password", password);

        return null;
      } else {
        return Future.value("Invalid Credentials :(");
      }
    }

    return FlutterLogin(
      title: "MoCo Monitor",
      // onLogin: (_) => Future(() => null),
      onLogin: authUser,
      onRecoverPassword: (_) => Future(() => null),
      // userValidator: (value) {
      //   if (value == null || value.isEmpty) {
      //     return 'Please enter some text';
      //   }
      //   return null;
      // },
      // userType: LoginUserType.name,
      // messages: LoginMessages(userHint: "123456", passwordHint: "Abcd1234"),
      // savedEmail: await credstore.getString("Student ID"),
    );
  }
}
