import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:moco_monitor/logic/data.dart';
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
        leading: BackButton(
          onPressed: () {
            data.shouldReload = false;
            context.vRouter.to('/');
          },
        ),
      ),
    );
  }
}
