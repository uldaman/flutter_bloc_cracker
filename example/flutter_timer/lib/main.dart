import 'package:flutter/material.dart';
import 'package:flutter_timer/blocs/counter/bloc.dart';
import 'package:wakelock/wakelock.dart';
import 'package:flutter_bloc_cracker/flutter_bloc_cracker.dart';
import 'package:flutter_timer/blocs/timer/bloc.dart';
import 'package:flutter_timer/views/timer.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final CounterBloc _counterBloc1 = CounterBloc();
  final TimerBloc _timerBloc1 = TimerBloc(60);
  final CounterBloc _counterBloc2 = CounterBloc();
  final TimerBloc _timerBloc2 = TimerBloc(30);

  @override
  void initState() {
    Wakelock.enable();
    super.initState();
  }

  Widget buildProvider(TimerBloc timer, CounterBloc counter) =>
      MultiBlocProvider(
        providers: [
          BlocProvider(bloc: counter),
          BlocProvider(bloc: timer),
        ],
        child: Timer(),
      );

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Color.fromRGBO(109, 234, 255, 1);
    return MaterialApp(
      theme: ThemeData(
        primaryColor: primaryColor,
        accentColor: Color.fromRGBO(72, 74, 126, 1),
        brightness: Brightness.dark,
      ),
      title: 'Flutter Timer',
      home: Scaffold(
        appBar: AppBar(title: Text('Flutter Timer')),
        body: Column(
          children: <Widget>[
            Expanded(child: buildProvider(_timerBloc1, _counterBloc1)),
            Divider(color: primaryColor, thickness: 1),
            Expanded(child: buildProvider(_timerBloc2, _counterBloc2)),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timerBloc1.dispose();
    _timerBloc2.dispose();
    super.dispose();
  }
}
