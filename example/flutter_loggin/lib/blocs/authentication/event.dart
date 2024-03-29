import 'package:flutter_bloc_cracker/flutter_bloc_cracker.dart';
import 'package:flutter_loggin/blocs/authentication/bloc.dart';
import 'package:flutter_loggin/blocs/authentication/state.dart';

abstract class AuthenticationEvent
    extends BlocEvent<AuthenticationState, AuthenticationBloc> {
  AuthenticationEvent({this.name: ''});
  final String name;
}

class AuthenticationEventLogin extends AuthenticationEvent {
  AuthenticationEventLogin({String name}) : super(name: name);

  @override
  Stream<AuthenticationState> handleEvent(
    AuthenticationBloc bloc,
    AuthenticationState currentState,
  ) async* {
    // Inform that we are proceeding with the authentication
    yield AuthenticationAuthenticating();

    // Simulate a call to the authentication server
    await Future.delayed(const Duration(seconds: 2));

    // Inform that we have successfuly authenticated, or not
    if (name == "failure") {
      yield AuthenticationFailure();
    } else {
      yield AuthenticationAuthenticated(name);
    }
  }
}

class AuthenticationEventLogout extends AuthenticationEvent {
  @override
  Stream<AuthenticationState> handleEvent(
    AuthenticationBloc bloc,
    AuthenticationState currentState,
  ) async* {
    yield AuthenticationNotAuthenticated();
  }
}
