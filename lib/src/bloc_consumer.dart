import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bloc_event_state.dart';

typedef AsyncBlocEventStateBuilder<BlocState,
        Bloc extends BlocCrackerBase<BlocState>>
    = Widget Function(
  BuildContext context,
  BlocState state,
  Bloc bloc,
  Widget child,
);

class BlocConsumer<BlocState, Bloc extends BlocCrackerBase<BlocState>>
    extends StatelessWidget {
  const BlocConsumer({
    Key key,
    @required this.builder,
    this.child,
  })  : assert(builder != null),
        super(key: key);

  final AsyncBlocEventStateBuilder<BlocState, Bloc> builder;
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
              builder(context, snapshot.data, bloc, child),
        );
      },
    );
  }
}
