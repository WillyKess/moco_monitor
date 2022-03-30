import 'package:studentvueclient/studentvueclient.dart';

class Data {
  late StudentVueClient client;
  late StudentGradeData classData;
  void init() {
    client = StudentVueClient(
        '452657', 'Enkv90132', 'md-mcps-psv.edupoint.com', true, false);
  }

  void updateClasses() async {
    classData = await client.loadGradebook();
    print(classData.classes?.elementAt(0).className);
  }
}

void main(List<String> args) {
  Data data = Data();
  data.init();
  data.updateClasses();
}
