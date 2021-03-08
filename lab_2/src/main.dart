import 'dart:async';
import 'dart:convert';

import 'model/vacancy/ProgrammerSystemAdminVacancy.dart';

void main() async {
  //Task 1
  var vacancy = ProgSysAdminVacancy("programmer and system administrator", 20000, ["C++", "Java"]);
  vacancy.doSomeSysAdminWork();
  print(vacancy.getInfo());
  print("--------------------------");

  //Task 2
  ProgVacancyIterable iterable = ProgVacancyIterable([
    vacancy,
    ProgSysAdminVacancy("name", 1000, null),
    ProgSysAdminVacancy("name2", 1050, null)
  ]);

  for(var vacancy in iterable) {
    print(vacancy.getInfo());
  }
  print("--------------------------");

  //Task 3
  print(jsonEncode(vacancy));
  print("--------------------------");

  //Task 4
  Future<String> longMethod() => Future.delayed(Duration(seconds: 2), () => "2 seconds passed");

  void func() async {
    print("async start");
    print(await longMethod());
    print("async stop");
  }

  print("before async");
  func();
  print("after async");


  await Future.delayed(Duration(seconds: 3));
  print("Future Api start");
  longMethod().then((value) => print(value));
  print("After longMethod in code");
  await Future.delayed(Duration(seconds: 5));

  //Task 6

  Stream<int> countStream(int to) async* {
    for (int i = 1; i <= to; i++) {
      await Future.delayed(Duration(milliseconds: 250));
      yield i;
    }
  }

  countStream(10).forEach((element) {
    print(element);
  });

  await Future.delayed(Duration(seconds:5));

  countStream(5).listen(
      (event) {
        print("wait");
      },
      onDone: ()
      {
        print("done");
      }
  );


  await Future.delayed(Duration(seconds:5));

  StreamController<int> controller = StreamController<int>.broadcast();

  controller.stream.listen((event) {
    print("listener1: $event");
  });
  controller.stream.listen((event) {
    print("listener2 ${-event}");
  });

  controller.sink.addStream(countStream(10));



}

