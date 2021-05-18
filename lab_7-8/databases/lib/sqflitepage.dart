import 'package:databases/datawidget.dart';
import 'package:databases/model/vacancy.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'db/sqflite.dart';

class SQFLitePage extends StatefulWidget {
  @override
  _SQFLitePageState createState() => _SQFLitePageState();
}

class _SQFLitePageState extends State<SQFLitePage> {

  @override
  Widget build(BuildContext context) {
    return DataWidget(
      title: Text("Vacancies SQFLite"),
      dataSource: DBProvider.db,
    );
  }
}