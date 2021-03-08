import 'Vacancy.dart';

class WaiterVacancy extends Vacancy {
  @override
  String? vacancyName;
  @override
  bool isActive = false;
  @override
  int salary = 0;
  List<String> requiredSkills = [];

  WaiterVacancy.name(this.vacancyName);
  WaiterVacancy(this.vacancyName, this.salary, this.requiredSkills);

  @override
  String getInfo() {
    return "name = $vacancyName, salary = $salary, ${isActive ? "active" : "inactive"}";
  }

}