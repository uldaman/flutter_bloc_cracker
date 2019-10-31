import 'package:flutter/material.dart';
import 'package:flutter_bloc_cracker/flutter_bloc_cracker.dart';

import '../blocs/bloc_auth.dart';

class AuthenticationPage extends StatelessWidget {
  ///
  /// Prevents the use of the "back" button
  ///
  Future<bool> _onWillPopScope() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Authentication Page'),
            leading: Container(),
          ),
          body: BlocConsumer<AuthenticationState, AuthenticationBloc>(
            builder: (context, bloc, state, _) {
              if (state.isAuthenticating) {
                return Container(
                  child: Center(child: Text('authenticating...')),
                );
              }

              if (state.isAuthenticated) {
                return Container();
              }

              List<Widget> children = <Widget>[];

              // Button to fake the authentication (success)
              children.add(
                ListTile(
                  title: RaisedButton(
                    child: Text('Log in (success)'),
                    onPressed: () {
                      bloc.emit(AuthenticationEventLogin(name: 'Didier'));
                    },
                  ),
                ),
              );

              // Button to fake the authentication (failure)
              children.add(
                ListTile(
                  title: RaisedButton(
                    child: Text('Log in (failure)'),
                    onPressed: () {
                      bloc.emit(
                        AuthenticationEventLogin(name: 'failure'),
                      );
                    },
                  ),
                ),
              );

              // Display a text if the authentication failed
              if (state.hasFailed) {
                children.add(Text('Authentication failure!'));
              }

              return Column(
                children: children,
              );
            },
          ),
        ),
      ),
    );
  }
}
