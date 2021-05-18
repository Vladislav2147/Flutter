import 'package:databases/model/vacancy.dart';

abstract class SimpleDataSource {
  newVacancy(Vacancy newVacancy);
  
  Future<List<Vacancy>> getAllVacancies();

  deleteVacancy(int id);
}