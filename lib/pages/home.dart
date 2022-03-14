import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:moco_monitor/logic/data.dart';
import 'package:moco_monitor/logic/navigator.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:studentvueclient/studentvueclient.dart';
// import 'package:get/get.dart';

import '../logic/storage.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Prefs prefs = GetIt.instance<Prefs>();
    StudentGradeData schooldata = GetIt.instance<Data>().data;
    if (!prefs.hasValidCredentials) {
      myNavigator.toAndRemoveUntil('/login');
    }
    return Scaffold(
      appBar: AppBar(title: Text(schooldata.studentName ?? '')),
      body: Container(
        child: ListView.builder(
          itemCount: schooldata.classes?.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              color: Colors.deepPurpleAccent,
              child: Center(
                  child: Text(
                      schooldata.classes?.elementAt(index).className ?? '')),
            );
          },
        ),
        alignment: AlignmentDirectional.center,
      ),
    );
    // return const Text("e");
  }
}
