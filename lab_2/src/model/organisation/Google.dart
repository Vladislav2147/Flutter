import '../vacancy/Vacancy.dart';
import 'Organisation.dart';

class Google extends Organisation {
  static String organisationName = "Google inc.";
  Google(String address, [List<Vacancy>? vacancies]) : super(address, vacancies == null ? new List<Vacancy>.empty() : vacancies);

  static String getOrganisationName() {
    return organisationName;
  }
  
}