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
    if (GetIt.instance<Prefs>().get("Username").isNotEmpty ||
        GetIt.instance<Prefs>().get("Username").isNotEmpty) {
      Data data = GetIt.instance<Data>();
      // Future<StudentGradeData?> _gradeData =
      //     data.refreshGradeData().then((value) => data.gradeData);
      Future<StudentGradeData?> _gradeData = data.refreshGradeData();
      return FutureBuilder(
        future: _gradeData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return classList(snapshot.data as StudentGradeData);
          } else if (snapshot.hasError) {
            context.vRouter.to('/login');
            return Transform.scale(
              scale: 0.5,
              child: const CircularProgressIndicator(),
            );
          } else {
            return Transform.scale(
              scale: 0.04,
              child: const CircularProgressIndicator(
                strokeWidth: 40.0,
              ),
            );
          }
        },
      );
    } else {
      context.vRouter.to('/login');
      return const CircularProgressIndicator();
    }
  }

  Container classList(StudentGradeData gradeData) {
    return Container(
      child: ListView.builder(
        itemCount: gradeData.classes?.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              color: Colors.pink,
              child: Center(
                  child: Text(
                      gradeData.classes?.elementAt(index).className ?? '')),
            ),
          );
        },
      ),
      alignment: Alignment.center,
    );
  }
}
