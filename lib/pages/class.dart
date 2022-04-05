import 'package:flutter/material.dart';
import 'package:flutter_nord_theme/flutter_nord_theme.dart';
import 'package:get_it/get_it.dart';
import 'package:moco_monitor/logic/data.dart';
import 'package:moco_monitor/pages/home.dart';
import 'package:studentvueclient/studentvueclient.dart';
import 'package:vrouter/vrouter.dart';

class Class extends StatelessWidget {
  const Class({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Data data = GetIt.instance<Data>();
    SchoolClass classData = data.gradeData.classes?.singleWhere(
          ((element) =>
              element.className?.replaceAll(' ', '') ==
              context.vRouter.pathParameters['id']),
          orElse: () {
            context.vRouter.to('/');
            return SchoolClass();
          },
        ) ??
        () {
          context.vRouter.to('/');
          return SchoolClass();
        }();
    return Scaffold(
      appBar: AppBar(
        title: Text(classData.className ?? ''),
        centerTitle: true,
      ),
      body: GradeList(classData.assignments ?? []),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              leading: ElevatedButton(
                onPressed: () {
                  data.shouldReload = false;
                  context.vRouter.to('/');
                },
                child: const Icon(Icons.home),
              ),
            ),
            ClassList(
              gradeData: data.gradeData,
              embeddedIfTrue: true,
            ),
          ],
        ),
      ),
    );
  }
}

class GradeList extends StatelessWidget {
  final List<Assignment> assignments;
  const GradeList(this.assignments, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: assignments.length,
      itemBuilder: (BuildContext context, int index) {
        Assignment currentAssignment = assignments[index];
        Color color = NordColors.snowStorm.darkest;
        double grade = (currentAssignment.earnedPoints ??
            0 / (currentAssignment.possiblePoints ?? 0));
        if (grade >= 89.5) {
          color = NordColors.aurora.green;
        } else if (grade >= 79.5) {
          color = NordColors.frost.darker;
        } else if (grade >= 69.5) {
          color = NordColors.aurora.yellow;
        } else if (grade >= 59.5) {
          color = NordColors.aurora.orange;
        } else if (grade >= 0) {
          color = NordColors.aurora.red;
        }
        return ListTile(
          tileColor: color,
          title: Text(
            currentAssignment.assignmentName ?? '',
            style: TextStyle(
              decoration: TextDecoration.underline,
              decorationColor: ((currentAssignment.category ?? '')
                      .toLowerCase()
                      .contains('practice')
                  ? NordColors.aurora.yellow
                  : (currentAssignment.category ?? '')
                          .toLowerCase()
                          .contains('task')
                      ? NordColors.frost.lighter
                      : NordColors.snowStorm.darkest),
            ),
          ),
          trailing: Container(
            padding: const EdgeInsets.all(5.0),
            color: color,
            child: Text((grade != 0) ? (grade.toString() + '%') : 'n/a'),
          ),
        );
      },
    );
  }
}
