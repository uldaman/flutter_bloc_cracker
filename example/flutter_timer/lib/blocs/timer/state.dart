import 'package:meta/meta.dart';

@immutable
abstract class TimerState {
  TimerState(this.duration);

  final int duration;
}

class Ready extends TimerState {
  Ready(int duration) : super(duration);
}

class Paused extends TimerState {
  Paused(int duration) : super(duration);
}

class Running extends TimerState {
  Running(int duration) : super(duration);
}

class Finished extends TimerState {
  Finished() : super(0);
}
