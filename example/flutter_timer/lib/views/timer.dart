import 'package:flutter/material.dart';
import 'package:flutter_bloc_cracker/flutter_bloc_cracker.dart';
import 'package:flutter_timer/blocs/bloc.dart';
import 'package:flutter_timer/blocs/state.dart';
import 'package:flutter_timer/views/gym_actions.dart';

class Timer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 50.0),
          child: Center(
            child: BlocConsumer<TimerState, TimerBloc>(
              builder: (_, TimerState state, __, ___) {
                final String minutesStr = ((state.duration / 60) % 60)
                    .floor()
                    .toString()
                    .padLeft(2, '0');
                final String secondsStr =
                    (state.duration % 60).floor().toString().padLeft(2, '0');
                return Text(
                  '$minutesStr:$secondsStr',
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Courier New',
                  ),
                );
              },
            ),
          ),
        ),
        GymActions(),
      ],
    );
  }
}
