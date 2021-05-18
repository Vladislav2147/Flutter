import 'package:databases/db/data.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'model/vacancy.dart';


class DataWidget extends StatefulWidget {
  Text title;
  SimpleDataSource dataSource;


  DataWidget({this.title, this.dataSource});

  @override
  DataState createState() => DataState(title, dataSource);
}

class DataState extends State<DataWidget> {

  Text _title;
  SimpleDataSource _dataSource;


  DataState(this._title, this._dataSource);

  List<Vacancy> testVacancies = [
    Vacancy.info("Itechart", 500),
    Vacancy.info("Epam", 450),
    Vacancy.info("LeverX", 475),
    Vacancy.info("McDonalds", 10000),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: _title),
      body: FutureBuilder<List<Vacancy>>(
        future: _dataSource.getAllVacancies(),
        builder: (BuildContext context, AsyncSnapshot<List<Vacancy>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Vacancy item = snapshot.data[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.red),
                  onDismissed: (direction) {
                    _dataSource.deleteVacancy(item.id);
                  },
                  child: ListTile(
                      title: Text(item.name),
                      leading: Text(item.id.toString()),
                      trailing: Text(item.salary.toStringAsFixed(2))
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          Vacancy rnd = testVacancies[math.Random().nextInt(testVacancies.length)];
          await _dataSource.newVacancy(rnd);
          setState(() {});
        },
      ),
    );
  }
}