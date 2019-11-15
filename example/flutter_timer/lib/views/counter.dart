import 'package:flutter/material.dart';
import 'package:flutter_bloc_cracker/flutter_bloc_cracker.dart';
import 'package:flutter_timer/blocs/counter/bloc.dart';
import 'package:flutter_timer/blocs/counter/event.dart';

class Counter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<int, CounterBloc>(
      builder: (_, state, bloc, ___) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlineButton(
              child: Icon(Icons.remove),
              onPressed: state > 0 ? () => bloc.emit(Decrement()) : null,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Text('$state'),
            ),
            OutlineButton(
              child: Icon(Icons.add),
              onPressed: () => bloc.emit(Increment()),
            ),
          ],
        );
      },
    );
  }
}
