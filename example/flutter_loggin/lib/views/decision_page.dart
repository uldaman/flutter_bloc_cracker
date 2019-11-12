import 'package:flutter/material.dart';
import 'package:flutter_bloc_cracker/flutter_bloc_cracker.dart';
import 'package:flutter_loggin/blocs/authentication/bloc.dart';
import 'package:flutter_loggin/blocs/authentication/state.dart';
import 'package:flutter_loggin/views/auth_page.dart';
import 'package:flutter_loggin/views/home_page.dart';

class DecisionPage extends StatefulWidget {
  @override
  DecisionPageState createState() => DecisionPageState();
}

class DecisionPageState extends State<DecisionPage> {
  AuthenticationState oldAuthenticationState;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationState, AuthenticationBloc>(
      builder: (context, state, _, child) {
        if (state != oldAuthenticationState) {
          oldAuthenticationState = state;

          if (state is AuthenticationAuthenticated) {
            _redirectToPage(context, HomePage(state.name));
          } else if (state is AuthenticationNotAuthenticated) {
            _redirectToPage(context, AuthenticationPage());
          }
        }
        // This page does not need to display anything since it will
        // always remind behind any active page (and thus 'hidden').
        return child;
      },
      child: Container(),
    );
  }

  void _redirectToPage(BuildContext context, Widget page) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => page),
        ModalRoute.withName('/'), // 删除之前的路径, 直到 '/'
      );
    });
  }
}
