import '../vacancy/Vacancy.dart';
import '../vacancy/WaiterVacancy.dart';
import 'Organisation.dart';

class McDonalds extends Organisation {
  McDonalds(String address, List<Vacancy> vacancies) : super(address, vacancies == null ? new List<Vacancy>.empty() : vacancies);
}