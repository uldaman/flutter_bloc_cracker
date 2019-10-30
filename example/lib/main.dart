import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'blocs/bloc_auth.dart';
import 'views/decision_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthenticationBloc>.value(
      value: AuthenticationBloc(),
      child: MaterialApp(
        title: 'BLoC Samples',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          "/": (context) => DecisionPage(),
        },
        initialRoute: '/',
      ),
    );
  }
}
