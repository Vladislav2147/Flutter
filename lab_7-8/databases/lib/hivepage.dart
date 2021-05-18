import 'package:databases/db/hiveorm.dart';
import 'package:flutter/material.dart';

import 'datawidget.dart';


class HivePage extends StatefulWidget {
  @override
  _HivePageState createState() => _HivePageState();
}

class _HivePageState extends State<HivePage> {

  HiveOrm hiveOrm;

  @override
  void initState() {
    super.initState();
    hiveOrm = HiveOrm();
    hiveOrm.init();
  }

  @override
  Widget build(BuildContext context) {
    return DataWidget(
      title: Text("Vacancies Hive"),
      dataSource: hiveOrm,
    );
  }
}