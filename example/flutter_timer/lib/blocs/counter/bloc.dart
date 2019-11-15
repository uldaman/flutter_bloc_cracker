import 'package:meta/meta.dart';
import 'package:flutter_bloc_cracker/flutter_bloc_cracker.dart';

@immutable
class CounterBloc extends BlocCrackerBase<int> {
  @override
  int get initialState => 0;
}
