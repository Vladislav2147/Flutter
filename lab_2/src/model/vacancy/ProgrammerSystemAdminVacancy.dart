import 'ProgrammerVacancy.dart';
import 'SystemAdminVacancy.dart';

class ProgSysAdminVacancy extends ProgrammerVacancy
    with SystemAdminVacancy implements Comparable<ProgSysAdminVacancy> {

  ProgSysAdminVacancy(String vacancyName, int salary, List<String>? languages) : super(vacancyName, salary, languages);

  @override
  int compareTo(other) => salary - other.salary;

  Map toJson() => {
    'name': vacancyName,
    'salary': salary,
    'languages': languages
  };

}

class ProgVacancyIterable extends Iterable<ProgSysAdminVacancy> {

  ProgVacancyIterable(this.vacancies);
  final List<ProgSysAdminVacancy> vacancies;

  @override
  Iterator<ProgSysAdminVacancy> get iterator => ProgIterator(vacancies);

}

class ProgIterator implements Iterator<ProgSysAdminVacancy> {
  ProgIterator(this.vacancies);
  List<ProgSysAdminVacancy> vacancies;
  ProgSysAdminVacancy? _current;
  int _index = 0;
  @override
  ProgSysAdminVacancy get current => _current!;

  @override
  bool moveNext() {
    if (_index + 1 > vacancies.length) return false;
    else _current = vacancies[_index++];
    return true;
  }

}