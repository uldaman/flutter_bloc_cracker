import 'package:meta/meta.dart';
import 'package:flutter_timer/blocs/counter/bloc.dart';
import 'package:flutter_bloc_cracker/flutter_bloc_cracker.dart';

@immutable
abstract class CounterEvent extends BlocEvent<int, CounterBloc> {}

class Decrement extends CounterEvent {
  @override
  Stream<int> handleEvent(CounterBloc bloc, int currentState) async* {
    yield currentState - 1;
  }
}

class Increment extends CounterEvent {
  @override
  Stream<int> handleEvent(CounterBloc bloc, int currentState) async* {
    yield currentState + 1;
  }
}
