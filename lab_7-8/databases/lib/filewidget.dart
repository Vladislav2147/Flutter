import 'dart:ffi';

import 'package:databases/db/filestorage.dart';
import 'package:databases/db/hiveorm.dart';
import 'package:flutter/material.dart';

import 'datawidget.dart';


class FileWidget extends StatefulWidget {
  void Function() writeFunc;
  void Function() readFunc;
  String text;


  FileWidget({this.writeFunc, this.readFunc, this.text});

  @override
  _FileWidgetState createState() => _FileWidgetState(writeFunc, readFunc, text);
}

class _FileWidgetState extends State<FileWidget> {

  void Function() writeFunc;
  void Function() readFunc;
  String text;


  _FileWidgetState(this.writeFunc, this.readFunc, this.text);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(text, style: TextStyle(fontSize: 22)),
          ],
        ),
        Row(
          children: [
            Container(
              margin: EdgeInsets.all(4),
              child: ElevatedButton(
                  onPressed: writeFunc,
                  child: Text("Write", style: TextStyle(fontSize: 22))
              ),
            ),
            Container(
              margin: EdgeInsets.all(4),
              child: ElevatedButton(
                  onPressed: readFunc,
                  child: Text("Read", style: TextStyle(fontSize: 22))
              ),
            ),
          ],
        )
      ],
    );
  }
}