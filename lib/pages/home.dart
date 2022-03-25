import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:moco_monitor/logic/data.dart';
import 'package:moco_monitor/logic/storage.dart';
import 'package:studentvueclient/studentvueclient.dart';
import 'package:vrouter/vrouter.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (GetIt.instance<Prefs>().get("Username").isNotEmpty &&
        GetIt.instance<Prefs>().get("Password").isNotEmpty) {
      Data dataClass = GetIt.instance<Data>();
      Future<StudentGradeData?> _gradeData = dataClass.refreshData();
      return FutureBuilder(
        future: _gradeData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            debugPrint(snapshot.data.toString() +
                "\n\n" +
                dataClass.studentData.toString());
            String name = dataClass.studentData.nickname ??
                dataClass.studentData.formattedName ??
                '';
            return classList(snapshot.data as StudentGradeData, name);
          } else if (snapshot.hasError) {
            context.vRouter.to('/login');
            return Transform.scale(
                scale: 0.04,
                child: const CircularProgressIndicator(strokeWidth: 40.0));
          } else {
            return Transform.scale(
                scale: 0.04,
                child: const CircularProgressIndicator(strokeWidth: 40.0));
          }
        },
      );
    } else {
      context.vRouter.to('/login');
      return const CircularProgressIndicator();
    }
  }

  Scaffold classList(StudentGradeData gradeData, String name) {
    return Scaffold(
      appBar: AppBar(title: Text("Hello, " + name)),
      body: Container(
        child: ListView.builder(
          itemCount: (() {
            gradeData.classes?.removeWhere((element) =>
                (element.className ?? '').toLowerCase().contains('lunch') &&
                (element.letterGrade ?? '').toLowerCase().contains('n/a'));
            return (gradeData.classes)?.length;
          })(),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: const EdgeInsets.all(12.0),
              child: ListTile(
                tileColor: Theme.of(context).backgroundColor,
                leading: Text(
                  gradeData.classes?.elementAt(index).className ?? '',
                  style: const TextStyle(fontSize: 18),
                ),
                trailing: RichText(
                  text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                          text: (gradeData.classes
                                  ?.elementAt(index)
                                  .letterGrade ??
                              ''),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.5),
                        ),
                        const TextSpan(text: "  "),
                        TextSpan(
                          text: (gradeData.classes?.elementAt(index).pctGrade ??
                              ''),
                          // style: const TextStyle(fontSize: 14),
                        ),
                      ]),
                ),
              ),
            );
          },
        ),
        alignment: Alignment.center,
      ),
    );
  }
}
