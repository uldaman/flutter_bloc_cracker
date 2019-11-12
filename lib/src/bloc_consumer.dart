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

typedef BlocBuilderEquals<BlocState> = bool Function(
  BlocState previous,
  BlocState current,
);

class BlocConsumer<BlocState, Bloc extends BlocCrackerBase<BlocState>>
    extends StatelessWidget {
  const BlocConsumer({
    Key key,
    @required this.builder,
    this.child,
    this.distinct,
  })  : assert(builder != null),
        super(key: key);

  final AsyncBlocEventStateBuilder<BlocState, Bloc> builder;
  final Widget child;
  final BlocBuilderEquals<BlocState> distinct;

  @override
  Widget build(BuildContext context) {
    return Consumer<Bloc>(
      child: child,
      builder: (context, bloc, child) {
        return StreamBuilder<BlocState>(
          stream: distinct != null ? bloc.state.distinct(distinct) : bloc.state,
          initialData: bloc.initialState,
          builder: (BuildContext context, AsyncSnapshot<BlocState> snapshot) =>
              builder(context, snapshot.data, bloc, child),
        );
      },
    );
  }
}
