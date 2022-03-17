import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:moco_monitor/logic/data.dart';
import 'package:moco_monitor/pages/home.dart';
import 'package:moco_monitor/pages/login.dart';
import 'package:vrouter/vrouter.dart';
import 'logic/storage.dart';

void main() {
  GetIt.instance.registerSingleton<Prefs>(Prefs());
  GetIt.instance.registerSingleton<Data>(Data());

  runApp(
    VRouter(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      routes: [
        VGuard(
          afterEnter: (context, from, to) {
            GetIt.instance<Data>().validCreds
                ? null
                : context.vRouter.to('/login');
          },
          // beforeEnter: (vRedirector) async {
          //   data.isLoggedIn ? null : vRedirector.to('/login');
          // },
          stackedRoutes: [VWidget(path: '/', widget: const Home())],
        ),
        VWidget(path: '/login', widget: const LoginScreen()),
        VRouteRedirector(
          redirectTo: '/',
          path: r'*',
        )
      ],
    ),
  );
}
