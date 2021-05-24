abstract class BlocEvent {
}

class TextEvent extends BlocEvent {
  String text;

  TextEvent(this.text);
}

class SqlFireSwitchEvent extends BlocEvent {
}