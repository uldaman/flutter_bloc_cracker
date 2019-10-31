import 'package:flutter/widgets.dart';
import 'package:flutter_bloc_cracker/flutter_bloc_cracker.dart';

class AuthenticationBloc extends BlocEventStateBase<AuthenticationState> {
  @override
  AuthenticationState get initialState =>
      AuthenticationState.notAuthenticated();
}

abstract class AuthenticationEvent extends BlocEvent<AuthenticationState> {
  AuthenticationEvent({this.name: ''});
  final String name;
}

class AuthenticationEventLogin extends AuthenticationEvent {
  AuthenticationEventLogin({String name}) : super(name: name);

  @override
  Stream<AuthenticationState> handleEvent(
      AuthenticationState currentState) async* {
    // Inform that we are proceeding with the authentication
    yield AuthenticationState.authenticating();

    // Simulate a call to the authentication server
    await Future.delayed(const Duration(seconds: 2));

    // Inform that we have successfuly authenticated, or not
    if (name == "failure") {
      yield AuthenticationState.failure();
    } else {
      yield AuthenticationState.authenticated(name);
    }
  }
}

class AuthenticationEventLogout extends AuthenticationEvent {
  @override
  Stream<AuthenticationState> handleEvent(
      AuthenticationState currentState) async* {
    yield AuthenticationState.notAuthenticated();
  }
}

class AuthenticationState {
  AuthenticationState._internal({
    @required this.isAuthenticated,
    this.isAuthenticating: false,
    this.hasFailed: false,
    this.name: '',
  });

  final bool isAuthenticated;
  final bool isAuthenticating;
  final bool hasFailed;
  final String name;

  factory AuthenticationState.notAuthenticated() =>
      AuthenticationState._internal(isAuthenticated: false);

  factory AuthenticationState.authenticated(String name) =>
      AuthenticationState._internal(isAuthenticated: true, name: name);

  factory AuthenticationState.authenticating() => AuthenticationState._internal(
      isAuthenticated: false, isAuthenticating: true);

  factory AuthenticationState.failure() =>
      AuthenticationState._internal(isAuthenticated: false, hasFailed: true);
}
