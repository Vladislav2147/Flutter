import 'dart:async';
import 'dart:convert';

import 'package:databases/model/vacancy.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data.dart';

class VacancySharedPrefs implements SimpleDataSource {
  @override
  deleteVacancy(int id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<Vacancy> vacancies = _listFromJson(sharedPreferences.getString("vacancies"));
    vacancies.removeWhere((element) => element.id == id);
    await sharedPreferences.setString("vacancies", _listToJson(vacancies));
  }

  @override
  Future<List<Vacancy>> getAllVacancies() async {
    List<Vacancy> vacancies = [];
    Completer completer = new Completer<List<Vacancy>>();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    vacancies = _listFromJson(sharedPreferences.getString("vacancies"));
    completer.complete(vacancies);
    return completer.future;
  }

  @override
  newVacancy(Vacancy newVacancy) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (!sharedPreferences.containsKey("counter")) {
      sharedPreferences.setInt("counter", 0);
    }
    int id = sharedPreferences.getInt("counter");
    newVacancy.id = id;
    await sharedPreferences.setInt("counter", id + 1);


    if (!sharedPreferences.containsKey("vacancies")) {
      List<Vacancy> emptyVacancies = [];
      await sharedPreferences.setString("vacancies", _listToJson(emptyVacancies));
    }
    List<Vacancy> vacancies = _listFromJson(sharedPreferences.getString("vacancies"));
    vacancies.add(newVacancy);
    await sharedPreferences.setString("vacancies", _listToJson(vacancies));
  }

  _listFromJson(String json) {
    List<Vacancy> vacancies = (jsonDecode(json) as List).map((e) => Vacancy.fromMap(e)).toList();
    return vacancies;
  }

  _listToJson(List<Vacancy> vacancies) {
    return jsonEncode(vacancies.map((e) => e.toMap()).toList());
  }


}