import 'dart:convert';

import 'package:hive/hive.dart';

part 'vacancy.g.dart';


@HiveType(typeId: 1)
class Vacancy extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  double salary;

  Vacancy(this.id, this.name, this.salary);


  Vacancy.info(this.name, this.salary);

  Vacancy.clone(Vacancy vacancy) {
    this.id = vacancy.id;
    this.salary = vacancy.salary;
    this.name = vacancy.name;
  }

  factory Vacancy.fromMap(Map<String, dynamic> json) => new Vacancy(
    json["id"],
    json["name"],
    json["salary"]
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "salary": salary,
  };
}

Vacancy vacancyFromJson(String str) {
  final jsonData = json.decode(str);
  return Vacancy.fromMap(jsonData);
}

String vacancyToJson(Vacancy data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}