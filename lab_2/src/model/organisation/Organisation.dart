import '../exceptions/IllegalArgumentException.dart';
import '../vacancy/Vacancy.dart';

abstract class Organisation {
  String address;
  List<Vacancy> vacancies;

  Organisation(this.address, this.vacancies);

  void closeVacancy({required Vacancy vacancy, bool isThrow = false}) {
    if (vacancies.contains(vacancy)) {
      vacancy.isActive = false;
    } else if (isThrow) {
      throw new IllegalArgumentException("vacancies don't contain vacancy ${vacancy.getInfo()}");
    }
  }
}