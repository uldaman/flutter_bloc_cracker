import 'package:flutter/material.dart';
import 'package:flutter_bloc_cracker/flutter_bloc_cracker.dart';
import 'package:flutter_loggin/blocs/authentication/bloc.dart';
import 'package:flutter_loggin/blocs/authentication/event.dart';

class HomePage extends StatelessWidget {
  ///
  /// Prevents the use of the "back" button
  ///
  Future<bool> _onWillPopScope() async {
    return false;
  }

  const HomePage(this.userName);

  final String userName;

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc bloc =
        BlocProvider.of<AuthenticationBloc>(context);
    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Home Page'),
            leading: Container(),
          ),
          body: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('current user: $userName'),
                  IconButton(
                    icon: Icon(Icons.exit_to_app),
                    onPressed: () {
                      bloc.emit(AuthenticationEventLogout());
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
