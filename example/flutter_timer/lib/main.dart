import 'package:flutter/material.dart';
import 'package:flutter_bloc_cracker/flutter_bloc_cracker.dart';
import 'package:flutter_timer/blocs/bloc.dart';
import 'package:flutter_timer/views/timer.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TimerBloc _timerBloc1 = TimerBloc(60);
  final TimerBloc _timerBloc2 = TimerBloc(30);

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
            Expanded(child: BlocProvider(bloc: _timerBloc1, child: Timer())),
            Divider(color: primaryColor, thickness: 1),
            Expanded(child: BlocProvider(bloc: _timerBloc2, child: Timer())),
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
