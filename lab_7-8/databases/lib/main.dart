import 'package:databases/filestoragepage.dart';
import 'package:databases/hivepage.dart';
import 'package:databases/model/vacancy.dart';
import 'package:databases/sharedpage.dart';
import 'package:databases/sqflitepage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'dart:math' as math;

import 'db/sqflite.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}


class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    SQFLitePage(),
    SharedPage(),
    FileStoragePage(),
    HivePage()
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.storage),
            title: new Text('SQFlite'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.storage),
            title: new Text('Shared Prefs'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.storage),
            title: new Text('Storage'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.storage),
            title: new Text('Hive'),
          ),
        ],
      ),
    );
  }
}