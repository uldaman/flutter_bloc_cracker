import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bloc_event_state.dart';

class BlocProvider<Bloc extends BlocBase> extends StatelessWidget {
  BlocProvider({
    Key key,
    @required this.bloc,
    @required this.child,
  })  : assert(bloc != null),
        assert(child != null),
        super(key: key);

  final Bloc bloc;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Provider<Bloc>(
      builder: (_) => bloc,
      dispose: (_, value) => value.dispose(),
      child: child,
    );
  }

  static Bloc of<Bloc extends BlocBase>(BuildContext context) {
    return Provider.of<Bloc>(context);
  }
}
