import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

abstract class BlocBase {
  void dispose();
}

abstract class BlocEvent<BlocState, Bloc extends BlocCrackerBase<BlocState>> {
  Stream<BlocState> handleEvent(Bloc bloc, BlocState currentState);
}

@immutable
abstract class BlocCrackerBase<BlocState> implements BlocBase {
  BlocCrackerBase() {
    _eventController.listen((BlocEvent event) {
      BlocState currentState = _stateController.value ?? initialState;
      eventHandler(event, currentState).forEach(
        (BlocState newState) => _stateController.sink.add(newState),
      );
    });
  }

  final PublishSubject<BlocEvent> _eventController =
      PublishSubject<BlocEvent>();
  final BehaviorSubject<BlocState> _stateController =
      BehaviorSubject<BlocState>();

  Function(BlocEvent) get emit => _eventController.sink.add;
  Observable<BlocState> get state => _stateController;

  BlocState get initialState;

  Stream<BlocState> eventHandler(BlocEvent event, BlocState currentState) =>
      event.handleEvent(this, currentState);

  @mustCallSuper
  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}
