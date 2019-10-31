import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bloc_event_state.dart';

typedef Widget AsyncBlocEventStateBuilder<BlocState>(
  BuildContext context,
  BlocEventStateBase<BlocState> bloc,
  BlocState state,
  Widget child,
);

class BlocConsumer<BlocState, Bloc extends BlocEventStateBase<BlocState>>
    extends StatelessWidget {
  const BlocConsumer({
    Key key,
    @required this.builder,
    this.child,
  })  : assert(builder != null),
        super(key: key);

  final AsyncBlocEventStateBuilder<BlocState> builder;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Consumer<Bloc>(
      child: child,
      builder: (context, bloc, child) {
        return StreamBuilder<BlocState>(
          stream: bloc.state,
          initialData: bloc.initialState,
          builder: (BuildContext context, AsyncSnapshot<BlocState> snapshot) =>
              builder(context, bloc, snapshot.data, child),
        );
      },
    );
  }
}
