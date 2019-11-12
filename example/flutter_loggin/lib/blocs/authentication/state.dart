abstract class AuthenticationState {}

class AuthenticationNotAuthenticated extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  AuthenticationAuthenticated(this.name);
  final String name;
}

class AuthenticationAuthenticating extends AuthenticationState {}

class AuthenticationFailure extends AuthenticationState {}
