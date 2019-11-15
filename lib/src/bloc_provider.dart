import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bloc_event_state.dart';

class MultiBlocProvider extends StatelessWidget {
  const MultiBlocProvider({Key key, @required this.providers, this.child})
      : assert(providers != null),
        super(key: key);

  final List<SingleChildCloneableWidget> providers;
  final Widget child;

  @override
  Widget build(BuildContext context) =>
      MultiProvider(providers: providers, child: child);
}

class BlocProvider<Bloc extends BlocBase> extends StatelessWidget
    implements SingleChildCloneableWidget {
  const BlocProvider({Key key, @required this.bloc, this.child})
      : assert(bloc != null),
        super(key: key);

  final Bloc bloc;
  final Widget child;

  @override
  Widget build(BuildContext context) => Provider<Bloc>(
        builder: (_) => bloc,
        dispose: (_, value) => value.dispose(),
        child: child,
      );

  @override
  BlocProvider<Bloc> cloneWithChild(Widget child) =>
      BlocProvider(key: key, bloc: bloc, child: child);

  static Bloc of<Bloc extends BlocBase>(BuildContext context) =>
      Provider.of<Bloc>(context);
}
