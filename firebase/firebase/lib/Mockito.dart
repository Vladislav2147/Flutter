import 'package:firebase/util/DbHelper.dart';
import 'package:mockito/mockito.dart';

class Mockito extends Mock implements DbHelper {
  Mockito.withMocks({Mockito postHelper});
  Mockito();
}