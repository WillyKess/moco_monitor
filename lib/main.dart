import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:moco_monitor/logic/data.dart';
import 'package:moco_monitor/logic/navigator.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
// import 'package:get/get.dart';

import 'logic/storage.dart';

void main() async {
  // final prefs = RM.inject(() => Prefs()).state;
  // final data = RM.inject(() => Data());
  // ignore: unused_local_variable
  // final data = Data().inj();
  // final prefs = Prefs().inj();
  // prefs.state.init();
  GetIt.instance.registerSingleton<Prefs>(Prefs());
  // GetIt.instance<Prefs>().init();
  bool e = await GetIt.instance<Prefs>().init();
  debugPrint(e ? "true" : "false");
  GetIt.instance.registerSingleton<Data>(Data());
  myNavigator;

  // Get.put(prefs);
  runApp(MaterialApp.router(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    routeInformationParser: myNavigator.routeInformationParser,
    routerDelegate: myNavigator.routerDelegate,
  ));
}
