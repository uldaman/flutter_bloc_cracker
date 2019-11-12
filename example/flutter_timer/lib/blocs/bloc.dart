import 'package:meta/meta.dart';
import 'package:flutter_bloc_cracker/flutter_bloc_cracker.dart';
import 'package:flutter_timer/blocs/state.dart';
import 'package:flutter_timer/domains/ticker.dart';

@immutable
class TimerBloc extends BlocCrackerBase<TimerState> {
  TimerBloc(this.duration) : ticker = Ticker(duration);

  final Ticker ticker;
  final int duration;

  @override
  TimerState get initialState => Ready(duration);

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }
}
