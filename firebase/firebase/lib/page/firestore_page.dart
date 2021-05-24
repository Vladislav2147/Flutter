import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase/util/DbHelper.dart';
import 'package:firebase/bloc/BlocProvider.dart';
import 'package:firebase/bloc/MyBloc.dart';
import 'package:firebase/bloc/event.dart';

import '../model/vacancy.dart';

class FirestorePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _FirestorePageState();
}

class _FirestorePageState extends State<FirestorePage> {
  final MyBloc _bloc = MyBloc();
  bool _sqlFireSwitch = false;

  final idController = TextEditingController();
  final nameController = TextEditingController();
  final materialController = TextEditingController();
  final salaryController = TextEditingController();

  CollectionReference vacancyCollection = FirebaseFirestore.instance.collection('vacancy');

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    idController.dispose();
    nameController.dispose();
    materialController.dispose();
    salaryController.dispose();
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MyBloc>(
      bloc: _bloc,
      child: Container(
        child: Column(
          children: [
            StreamBuilder(
              stream: _bloc.switchState,
              initialData: false,
              builder: (context, snapshot) {
                return (snapshot.data as bool) ? Text('FIREBASE') : Text('SQLFLITE');
              }
            ),
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () { onCreate(); },
                  child: Text('CREATE'),
                ),
                ElevatedButton(
                  onPressed: () { onRead(context); },
                  child: Text('READ'),
                ),
                ElevatedButton(
                  onPressed: () { onUpdate(); },
                  child: Text('UPDATE'),
                ),
                ElevatedButton(
                  onPressed: () { onDelete(); },
                  child: Text('DELETE'),
                ),
              ],
            ),
            TextField(
              key: Key('test'),
              controller: idController,
              decoration: InputDecoration(
                hintText: 'id',
              ),
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'color',
              ),
            ),
            TextField(
              controller: salaryController,
              decoration: InputDecoration(
                hintText: 'salary',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('SQL'),
                Switch(
                  value: _sqlFireSwitch,
                  onChanged: (bool value) { setState(() { _sqlFireSwitch = !_sqlFireSwitch; }); _bloc.eventSink.add(SqlFireSwitchEvent()); },
                ),
                Text('FIRE'),
              ],
            ),
            StreamBuilder(
              stream: _bloc.textState,
              initialData: '',
              builder: (context, snapshot) {
                return Text(snapshot.data.toString());
              },
            ),
          ],
        ),
      ),
    );
  }

  void onCreate() async {
    Vacancy cloth = Vacancy(
      id: int.parse(idController.text),
      name: nameController.text,
      salary: double.parse(salaryController.text),
    );
    try {
      if (_sqlFireSwitch) {
        await vacancyCollection.add(cloth.toMap());
      } else {
        await DbHelper().insertCloth(cloth);
      }
    } catch (e) {
      print(e);
      return;
    }
    Fluttertoast.showToast(
      msg: 'Vacancy created',
    );
  }

  void onRead(BuildContext context) async {
    if (_sqlFireSwitch) {
      var res = await vacancyCollection.get();
      List<Vacancy> clothList = res.docs
        .map((doc) => Vacancy.fromDoc(doc))
        .toList();
      _bloc.eventSink.add(TextEvent(clothList.join(',\n')));
    } else {
      List<Vacancy> res = await DbHelper().getCloth();
      _bloc.eventSink.add(TextEvent(res.join(',\n')));
    }
  }

  void onUpdate() async {
    Vacancy cloth = Vacancy(
      id: int.parse(idController.text),
      name: nameController.text,
      salary: double.parse(salaryController.text),
    );
    if (_sqlFireSwitch) {
      var res = await vacancyCollection
        .where('id', isEqualTo: cloth.id)
        .get();
      res.docs.forEach((doc) {
        vacancyCollection
          .doc(doc.id)
          .update(cloth.toMap());
      });
      Fluttertoast.showToast(
        msg: 'Vacancy updated',
      );
    } else {
      DbHelper.updateCloth(cloth).then((res) {
        Fluttertoast.showToast(
          msg: 'Vacancy updated',
        );
      });
    }
  }

  void onDelete() async {
    if (_sqlFireSwitch) {
      var res = await vacancyCollection
          .where('id', isEqualTo: int.parse(idController.text))
          .get();
      res.docs.forEach((doc) {
        vacancyCollection
            .doc(doc.id)
            .delete();
      });
      Fluttertoast.showToast(
        msg: 'Vacancy deleted',
      );
    } else {
      DbHelper.deleteCloth(int.parse(idController.text)).then((res) {
        Fluttertoast.showToast(
          msg: 'Vacancy deleted',
        );
      });
    }
  }
}