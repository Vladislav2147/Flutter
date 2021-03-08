abstract class Vacancy {
  String? vacancyName;
  bool isActive = false;
  int _salary = 0;



  int get salary {
    return _salary;
  }

  set salary(int salary) {
    _salary = salary < 0 ? 0 : salary;
  }

  String getInfo();
}