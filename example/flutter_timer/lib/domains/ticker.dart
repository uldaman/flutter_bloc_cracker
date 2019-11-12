import 'dart:async';
import 'package:rxdart/rxdart.dart';

class Ticker {
  Ticker(this._ticks);

  final int _ticks;

  StreamSubscription<int> _subscription;

  void start(Function(int) f) => this
    ..dispose()
    .._subscript(f);

  void _subscript(Function(int) f) => _subscription =
      Observable.periodic(Duration(seconds: 1), (x) => _ticks - x - 1)
          .take(_ticks)
          .listen((duration) => f(duration));

  void pause() => _subscription?.pause();

  void resume() => _subscription?.resume();

  void dispose() => _subscription?.cancel();
}
