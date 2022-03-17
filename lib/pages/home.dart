import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:moco_monitor/logic/data.dart';
import 'package:studentvueclient/studentvueclient.dart';
import 'package:vrouter/vrouter.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Data data = GetIt.instance<Data>();
    Future<StudentGradeData?> _gradeData =
        data.refreshGradeData().then((value) => data.gradeData);
    return FutureBuilder(
      future: _gradeData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return classList(data.gradeData!);
        } else {
          return const Text("Waiting...");
        }
      },
    );
  }

  Container classList(StudentGradeData gradeData) {
    return Container(
      child: ListView.builder(
        itemCount: gradeData.classes?.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              color: Colors.deepPurpleAccent,
              child: Center(
                  child: Text(
                      gradeData.classes?.elementAt(index).className ?? '')),
            ),
          );
        },
      ),
      alignment: AlignmentDirectional.center,
    );
  }
}
