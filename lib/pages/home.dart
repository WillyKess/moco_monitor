import 'package:animated_text_kit/animated_text_kit.dart';
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
    Data dataClass = GetIt.instance<Data>();
    if (!(dataClass.shouldReload)) {
      return classList(dataClass.gradeData);
    } else if (GetIt.instance<Prefs>().get("Username").isNotEmpty &&
        GetIt.instance<Prefs>().get("Password").isNotEmpty) {
      Future<StudentGradeData?> _gradeData = dataClass.refreshData();
      return FutureBuilder(
        future: _gradeData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return classList(snapshot.data as StudentGradeData);
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

  Scaffold classList(StudentGradeData gradeData) {
    return Scaffold(
      appBar: AppBar(
        title: const NameGreeter(),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: (() {
            gradeData.classes?.removeWhere((element) =>
                (element.className ?? '').toLowerCase().contains('lunch') &&
                (element.letterGrade ?? '').toLowerCase().contains('n/a'));
            return (gradeData.classes)?.length;
          })(),
          itemBuilder: (BuildContext context, int index) {
            SchoolClass currentClass =
                gradeData.classes?.elementAt(index) ?? SchoolClass();
            return Container(
              padding: const EdgeInsets.all(12.0),
              child: ListTile(
                onTap: (() {
                  context.vRouter.to(
                      '/class/${currentClass.className?.replaceAll(' ', '')}');
                }),
                tileColor: Theme.of(context).backgroundColor,
                leading: Text(
                  currentClass.className ?? '',
                  style: const TextStyle(fontSize: 18),
                ),
                trailing: RichText(
                  text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                          text: (currentClass.letterGrade ?? ''),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.5),
                        ),
                        const TextSpan(text: "  "),
                        TextSpan(
                          text: (currentClass.pctGrade ?? ''),
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

class NameGreeter extends StatelessWidget {
  const NameGreeter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Data dataClass = GetIt.instance<Data>();
    if (!(dataClass.shouldReload)) {
      return Text((dataClass.studentData.nickname ??
              dataClass.studentData.formattedName ??
              'User') +
          '\'s classes:');
    } else {
      return FutureBuilder(
        future: dataClass.refreshStudentData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return AnimatedTextKit(isRepeatingAnimation: false, animatedTexts: [
              TyperAnimatedText(() {
                StudentData sdata = snapshot.data;
                return 'Hello, ' +
                    (sdata.nickname ?? sdata.formattedName ?? 'User');
              }(), speed: const Duration(milliseconds: 50))
            ]);
          } else {
            return const Text('');
          }
        },
      );
    }
  }
}
