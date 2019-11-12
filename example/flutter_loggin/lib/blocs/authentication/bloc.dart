import 'package:flutter_bloc_cracker/flutter_bloc_cracker.dart';
import 'package:flutter_loggin/blocs/authentication/state.dart';

class AuthenticationBloc extends BlocCrackerBase<AuthenticationState> {
  @override
  AuthenticationState get initialState => AuthenticationNotAuthenticated();
}
