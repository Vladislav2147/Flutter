import 'package:databases/db/sharedprefs.dart';
import 'package:databases/model/vacancy.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'datawidget.dart';
import 'db/sqflite.dart';


class SharedPage extends StatefulWidget {
  @override
  _SharedPageState createState() => _SharedPageState();
}

class _SharedPageState extends State<SharedPage> {

  @override
  Widget build(BuildContext context) {
    return DataWidget(
      title: Text("Vacancies SharedPrefs"),
      dataSource: VacancySharedPrefs(),
    );
  }
}