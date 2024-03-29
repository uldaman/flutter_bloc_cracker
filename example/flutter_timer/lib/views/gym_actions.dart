import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_bloc_cracker/flutter_bloc_cracker.dart';
import 'package:flutter_timer/blocs/timer/bloc.dart';
import 'package:flutter_timer/blocs/timer/event.dart';
import 'package:flutter_timer/blocs/timer/state.dart';

class GymActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TimerState, TimerBloc>(
      distinct: (previousState, currentState) =>
          currentState.runtimeType == previousState.runtimeType,
      builder: (_, state, bloc, ___) {
        List<Widget> children;

        if (state is Ready)
          children = [
            FloatingActionButton(
              child: Icon(Icons.play_arrow),
              onPressed: () => bloc.emit(Start()),
            ),
          ];

        if (state is Running)
          children = [
            FloatingActionButton(
              child: Icon(Icons.pause),
              onPressed: () => bloc.emit(Pause()),
            ),
            FloatingActionButton(
              child: Icon(Icons.replay),
              onPressed: () => bloc.emit(Reset()),
            ),
          ];

        if (state is Paused)
          children = [
            FloatingActionButton(
              child: Icon(Icons.play_arrow),
              onPressed: () => bloc.emit(Resume()),
            ),
            FloatingActionButton(
              child: Icon(Icons.replay),
              onPressed: () => bloc.emit(Reset()),
            ),
          ];

        if (state is Finished) {
          FlutterRingtonePlayer.play(
            android: AndroidSounds.notification,
            ios: IosSound(1031),
          );
          children = [
            FloatingActionButton(
              child: Icon(Icons.replay),
              onPressed: () => bloc.emit(Reset()),
            ),
          ];
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: children,
        );
      },
    );
  }
}
