import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

abstract class BlocEvent<BlocState> extends Object {
  Stream<BlocState> handleEvent(BlocState currentState);
}

@immutable
abstract class BlocEventStateBase<State, Event extends BlocEvent<State>> {
  BlocEventStateBase() {
    _eventController.listen((Event event) {
      State currentState = _stateController.value ?? initialState;
      eventHandler(event, currentState).forEach((State newState) {
        _stateController.sink.add(newState);
      });
    });
  }

  final PublishSubject<Event> _eventController = PublishSubject<Event>();
  final BehaviorSubject<State> _stateController = BehaviorSubject<State>();

  Function(Event) get emit => _eventController.sink.add;
  Observable<State> get state => _stateController;

  State get initialState;

  Stream<State> eventHandler(Event event, State currentState) =>
      event.handleEvent(currentState);

  @mustCallSuper
  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}
