import 'dart:async';

import 'package:firebase/bloc/event.dart';

import 'Bloc.dart';

class ShowTextBloc implements Bloc {
  String _text = '';

  final _textStateController = StreamController<String>();
  StreamSink<String> get _inText => _textStateController.sink;
  Stream<String> get text => _textStateController.stream;

  final _textEventController = StreamController<TextEvent>();
  Sink<TextEvent> get counterEventSink => _textEventController.sink;


  ShowTextBloc() {
    _textEventController.stream.listen(_eventToState);
  }

  void _eventToState(TextEvent event) {
    _text = event.text;
    _inText.add(_text);
  }

  @override
  void dispose() {
    _textStateController.close();
    _textEventController.close();
  }
}