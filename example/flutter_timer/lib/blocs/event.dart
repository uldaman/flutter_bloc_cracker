import 'package:meta/meta.dart';
import 'package:flutter_timer/blocs/bloc.dart';
import 'package:flutter_timer/blocs/state.dart';
import 'package:flutter_bloc_cracker/flutter_bloc_cracker.dart';

@immutable
abstract class TimerEvent extends BlocEvent<TimerState, TimerBloc> {}

class Start extends TimerEvent {
  @override
  Stream<TimerState> handleEvent(
    TimerBloc bloc,
    TimerState currentState,
  ) async* {
    assert(currentState is Ready);
    bloc.ticker.start((duration) => bloc.emit(Tick(duration)));
    yield Running(currentState.duration);
  }
}

class Pause extends TimerEvent {
  @override
  Stream<TimerState> handleEvent(
    TimerBloc bloc,
    TimerState currentState,
  ) async* {
    assert(currentState is Running);
    bloc.ticker.pause();
    yield Paused(currentState.duration);
  }
}

class Resume extends TimerEvent {
  @override
  Stream<TimerState> handleEvent(
    TimerBloc bloc,
    TimerState currentState,
  ) async* {
    assert(currentState is Paused);
    bloc.ticker.resume();
    yield Running(currentState.duration);
  }
}

class Reset extends TimerEvent {
  @override
  Stream<TimerState> handleEvent(
    TimerBloc bloc,
    TimerState currentState,
  ) async* {
    assert(currentState is! Ready);
    bloc.ticker.dispose();
    yield Ready(bloc.duration);
  }
}

class Tick extends TimerEvent {
  @override
  Stream<TimerState> handleEvent(
    TimerBloc bloc,
    TimerState currentState,
  ) async* {
    yield _duration > 0 ? Running(_duration) : Finished();
  }

  Tick(this._duration);

  final int _duration;
}
