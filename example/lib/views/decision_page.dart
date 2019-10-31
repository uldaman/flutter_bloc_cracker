import 'package:flutter/material.dart';
import 'package:flutter_bloc_cracker/flutter_bloc_cracker.dart';

import '../blocs/bloc_auth.dart';
import 'auth_page.dart';
import 'home_page.dart';

class DecisionPage extends StatefulWidget {
  @override
  DecisionPageState createState() => DecisionPageState();
}

class DecisionPageState extends State<DecisionPage> {
  AuthenticationState oldAuthenticationState;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationState, AuthenticationBloc>(
      builder: (context, _, state, child) {
        if (state != oldAuthenticationState) {
          oldAuthenticationState = state;

          if (state.isAuthenticated) {
            _redirectToPage(context, HomePage());
          } else if (state.isAuthenticating || state.hasFailed) {
            //do nothing
          } else {
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
