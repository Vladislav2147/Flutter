import 'Vacancy.dart';
import 'WaiterVacancy.dart';

class ProgrammerVacancy extends Vacancy {
  @override
  String? vacancyName;
  @override
  bool isActive = true;
  @override
  int salary = 0;
  List<String>? languages;

  ProgrammerVacancy.name(this.vacancyName);
  ProgrammerVacancy(this.vacancyName, this.salary, this.languages);

  @override
  String getInfo() {
    return "name = $vacancyName, salary = $salary, ${isActive ? "active" : "inactive"}";
  }


}