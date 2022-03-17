import 'package:get_it/get_it.dart';
import 'package:moco_monitor/logic/storage.dart';
import 'package:studentvueclient/studentvueclient.dart';

class Data {
  StudentGradeData? gradeData = StudentGradeData();
  bool validCreds = false;
  Data() {
    refreshGradeData();
  }
  Future<void> refreshGradeData() async {
    // ignore: await_only_futures
    await 1;
    Prefs prefs = GetIt.instance<Prefs>();
    try {
      gradeData = await StudentVueClient(prefs.get('Username'),
              prefs.get('Password'), 'md-mcps-psv.edupoint.com', true, false)
          .loadGradebook();
    } catch (e) {
      validCreds = false;
      return;
    }
    validCreds = (gradeData?.error ?? '').isEmpty;
  }
}

// Possible idea: use futurebuilder to await a valid login, and otherwise show the login screen. Can have a loading spinner that shows up when isLoggedIn is null (make it nullable too), and then based on whether or not it completes with true or false (or error maybe), show different screens. This would be super fast, easy to manage, and make sense.