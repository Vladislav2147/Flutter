import 'dart:async';
import 'dart:io';

import 'package:databases/db/data.dart';
import 'package:databases/model/vacancy.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveOrm implements SimpleDataSource {
  
  void init() async {
    final dir = await getApplicationDocumentsDirectory();
    print(dir.path);
    Hive.init(dir.path);
    Hive.registerAdapter(VacancyAdapter());
    Hive.openBox<Vacancy>('vacanciesHive');
    Hive.openBox<Vacancy>('vacanciesHive');
  }

  @override
  deleteVacancy(int id) async {
    var box = Hive.box<Vacancy>('vacanciesHive');
    box.delete(id);
  }

  @override
  Future<List<Vacancy>> getAllVacancies() async {
    Completer completer = new Completer<List<Vacancy>>();
    var box = Hive.box<Vacancy>('vacanciesHive');
    completer.complete(box.values.toList());
    return completer.future;
  }

  @override
  newVacancy(Vacancy newVacancy) async {
    var clone = Vacancy.clone(newVacancy);
    var box = Hive.box<Vacancy>('vacanciesHive');
    int id = await box.add(clone);
    clone.id = id;
    await clone.save();
  }
  
}