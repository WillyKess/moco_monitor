import 'package:flutter/material.dart';
import 'package:flutter_nord_theme/flutter_nord_theme.dart';
import 'package:get_it/get_it.dart';
import 'package:moco_monitor/logic/data.dart';
import 'package:moco_monitor/pages/class.dart';
import 'package:moco_monitor/pages/home.dart';
import 'package:moco_monitor/pages/login.dart';
import 'package:vrouter/vrouter.dart';
import 'logic/storage.dart';

void main() {
  GetIt.instance.registerSingleton<Prefs>(Prefs());
  GetIt.instance.registerSingleton<Data>(Data());

  runApp(
    VRouter(
      debugShowCheckedModeBanner: false,
      title: 'MoCo Monitor',
      themeMode: ThemeMode.dark,
      darkTheme: NordTheme.dark(),
      theme: NordTheme.light(),
      routes: [
        VWidget(path: '/', widget: const Home()),
        VWidget(path: '/login', widget: const LoginScreen()),
        VWidget(path: '/class/:id', widget: const Class()),
        VRouteRedirector(
          redirectTo: '/',
          path: r'*',
        )
      ],
    ),
  );
}
