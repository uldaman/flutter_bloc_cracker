import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

abstract class BlocBase {
  void dispose();
}

abstract class BlocEvent<BlocState> extends Object {
  Stream<BlocState> handleEvent(
    BlocCrackerBase<BlocState> bloc,
    BlocState currentState,
  );
}

@immutable
abstract class BlocCrackerBase<BlocState> implements BlocBase {
  BlocCrackerBase() {
    _eventController.listen((BlocEvent<BlocState> event) {
      BlocState currentState = _stateController.value ?? initialState;
      eventHandler(event, currentState).forEach(
        (BlocState newState) => _stateController.sink.add(newState),
      );
    });
  }

  final PublishSubject<BlocEvent<BlocState>> _eventController =
      PublishSubject<BlocEvent<BlocState>>();
  final BehaviorSubject<BlocState> _stateController =
      BehaviorSubject<BlocState>();

  Function(BlocEvent<BlocState>) get emit => _eventController.sink.add;
  Observable<BlocState> get state => _stateController;

  BlocState get initialState;

  Stream<BlocState> eventHandler(
    BlocEvent<BlocState> event,
    BlocState currentState,
  ) =>
      event.handleEvent(this, currentState);

  @mustCallSuper
  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}
