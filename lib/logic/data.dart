import 'package:get_it/get_it.dart';
import 'package:moco_monitor/logic/storage.dart';
import 'package:studentvueclient/studentvueclient.dart';

class Data {
  bool shouldReload = true;
  StudentGradeData gradeData = StudentGradeData();
  StudentData studentData = StudentData();
  Future<StudentGradeData> refreshData() async {
    // ignore: await_only_futures
    await 1;
    Prefs prefs = GetIt.instance<Prefs>();
    String username = prefs.get('Username');
    String password = prefs.get('Password');

    try {
      gradeData = await StudentVueClient(
              username, password, 'md-mcps-psv.edupoint.com', true, false)
          .loadGradebook();
    } catch (e) {
      throw Exception("The credentials ($username, $password) were invalid");
    }
    if ((gradeData.error ?? '').isNotEmpty) {
      throw Exception("The credentials ($username, $password) were invalid");
    } else {
      // refreshStudentData(username, password, this);
      return Future<StudentGradeData>.value(gradeData);
    }
    //todo: make this much simpler and/or less LOC
  }

  Future<StudentData> refreshStudentData() async {
    // ignore: await_only_futures
    await 1;
    Prefs prefs = GetIt.instance<Prefs>();
    String username = prefs.get('Username');
    String password = prefs.get('Password');
    studentData = await StudentVueClient(
            username, password, 'md-mcps-psv.edupoint.com', true, true)
        .loadStudentData();
    return studentData;
  }
}
