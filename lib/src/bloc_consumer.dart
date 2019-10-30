import 'package:flutter/material.dart';
import 'bloc_event_state.dart';

typedef Widget AsyncBlocEventStateBuilder<BlocState>(
    BuildContext context, BlocState state);

class BlocConsumer<State, Event extends BlocEvent<State>>
    extends StatelessWidget {
  const BlocConsumer({
    Key key,
    @required this.builder,
    @required this.bloc,
  })  : assert(builder != null),
        assert(bloc != null),
        super(key: key);

  final BlocEventStateBase<State, Event> bloc;
  final AsyncBlocEventStateBuilder<State> builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<State>(
      stream: bloc.state,
      initialData: bloc.initialState,
      builder: (BuildContext context, AsyncSnapshot<State> snapshot) =>
          builder(context, snapshot.data),
    );
  }
}
