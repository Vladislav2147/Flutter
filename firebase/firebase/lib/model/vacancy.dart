import 'package:cloud_firestore/cloud_firestore.dart';

class Vacancy {
  int id;
  String name;
  double salary;

  Vacancy({this.id, this.name, this.salary});

  static Vacancy fromDoc(QueryDocumentSnapshot doc) {
    return Vacancy(
      id: doc['id'],
      name: doc['color'],
      salary: doc['pocketNumber'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'color': name,
      'pocketNumber': salary,
    };
  }

  @override
  String toString() {
    return 'Vacancy{id: $id, name: $name, salary: $salary}';
  }
}
