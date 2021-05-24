import 'dart:async';

import 'package:firebase/bloc/event.dart';

import 'Bloc.dart';

class MyBloc implements Bloc {
  String _text = '';
  bool _sqlFireSwitch = false;

  final _textStateController = StreamController<String>();
  StreamSink<String> get _inTextState => _textStateController.sink;
  Stream<String> get textState => _textStateController.stream;

  final _sqlFireSwitchController = StreamController<bool>();
  StreamSink<bool> get _inSwitchState => _sqlFireSwitchController.sink;
  Stream<bool> get switchState => _sqlFireSwitchController.stream;

  final _eventController = StreamController<BlocEvent>();
  Sink<BlocEvent> get eventSink => _eventController.sink;


  MyBloc() {
    _eventController.stream.listen(_eventToState);
  }

  void _eventToState(BlocEvent event) {
    if (event is TextEvent) {
      _text = event.text;
      _inTextState.add(_text);
    } else if (event is SqlFireSwitchEvent) {
      _sqlFireSwitch = !_sqlFireSwitch;
      _inSwitchState.add(_sqlFireSwitch);
    }
  }

  @override
  void dispose() {
    _textStateController.close();
    _sqlFireSwitchController.close();
    _eventController.close();
  }
}