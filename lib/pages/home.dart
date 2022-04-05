import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nord_theme/flutter_nord_theme.dart';
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
      return Scaffold(
        appBar: AppBar(
          title: const NameGreeter(),
        ),
        body: ClassList(gradeData: dataClass.gradeData),
      );
    } else if (GetIt.instance<Prefs>().get("Username").isNotEmpty &&
        GetIt.instance<Prefs>().get("Password").isNotEmpty) {
      Future<StudentGradeData?> _gradeData = dataClass.refreshData();
      return FutureBuilder(
        future: _gradeData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                appBar: AppBar(
                  title: const NameGreeter(),
                ),
                body: ClassList(
                  gradeData: (snapshot.data as StudentGradeData),
                ));
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
      return const SizedBox(
          width: 100, height: 100, child: CircularProgressIndicator());
    }
  }
}

class ClassList extends StatelessWidget {
  final StudentGradeData gradeData;
  final bool? embeddedIfTrue;
  const ClassList({
    Key? key,
    required this.gradeData,
    this.embeddedIfTrue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isEmbedded = (embeddedIfTrue != null);
    return ListView.builder(
      shrinkWrap: isEmbedded,
      physics: isEmbedded
          ? const NeverScrollableScrollPhysics()
          : const ScrollPhysics(),
      itemCount: (() {
        gradeData.classes?.removeWhere((element) =>
            (element.className ?? '').toLowerCase().contains('lunch') &&
            (element.letterGrade ?? '').toLowerCase().contains('n/a'));
        return (gradeData.classes)?.length;
      })(),
      itemBuilder: (BuildContext context, int index) {
        SchoolClass currentClass =
            gradeData.classes?.elementAt(index) ?? SchoolClass();
        Container letterGradeColor(String? grade) {
          Color color = NordColors.snowStorm.darkest;
          switch (grade) {
            case 'A':
              color = NordColors.aurora.green;
              break;
            case 'B':
              color = NordColors.frost.darker;
              break;
            case 'C':
              color = NordColors.aurora.yellow;
              break;
            case 'D':
              color = NordColors.aurora.orange;
              break;
            case 'E':
              color = NordColors.aurora.red;
              break;
          }
          return Container(
            padding: const EdgeInsets.all(5.0),
            color: color,
            child: Text(
              currentClass.letterGrade ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          );
        }

        return Container(
          padding: const EdgeInsets.all(12.0),
          child: ListTile(
              onTap: (() {
                context.vRouter.to(
                    '/class/${currentClass.className?.replaceAll(' ', '')}');
              }),
              tileColor: NordColors.frost.darker,
              title: Text(
                currentClass.className ?? '',
                style: const TextStyle(fontSize: 18),
              ),
              trailing: () {
                if (isEmbedded) {
                  return letterGradeColor(currentClass.letterGrade);
                } else {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      letterGradeColor(currentClass.letterGrade),
                      Text('    ' + (currentClass.pctGrade ?? '') + '%')
                    ],
                  );
                }
              }()),
        );
      },
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
