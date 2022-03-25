import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get_it/get_it.dart';
import 'package:vrouter/vrouter.dart';
import 'package:moco_monitor/logic/auth.dart';
import 'package:moco_monitor/logic/storage.dart';

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
      onSubmitAnimationCompleted: () => context.vRouter.to('/'),
      savedEmail: prefs.get('Username'),
      savedPassword: prefs.get('Password'),
    );
  }
}
