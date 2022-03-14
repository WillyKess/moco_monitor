import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get_it/get_it.dart';
import 'package:moco_monitor/logic/navigator.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import '../logic/auth.dart';
import '../logic/storage.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  build(BuildContext context) {
    Prefs prefs = GetIt.instance<Prefs>();
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
      onSubmitAnimationCompleted: () => myNavigator.toAndRemoveUntil('/'),
      savedEmail: prefs.get("Username"),
      savedPassword: prefs.get("Password"),
    );
  }
}
