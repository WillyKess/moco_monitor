import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:moco_monitor/logic/storage.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:studentvueclient/studentvueclient.dart';

class Data {
  late StudentGradeData data;
}

Future<StudentGradeData> getData() async {
  return await StudentVueClient(
          GetIt.instance<Prefs>().get('Username'),
          GetIt.instance<Prefs>().get('Password'),
          'md-mcps-psv.edupoint.com',
          true,
          false)
      .loadGradebook();
}
