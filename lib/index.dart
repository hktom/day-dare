import 'package:application_challenge/authentification/bloc/authentification_bloc.dart';
import 'package:application_challenge/authentification/screens/signIn.dart';
import 'package:application_challenge/bloc.dart';
import 'package:application_challenge/challenge/bloc/challenge_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  @override
  void initState() {
    super.initState();
    authentificationBloc(context).add(OnCheckUserAuth());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthentificationBloc, AuthentificationState>(
      builder: (context, state) {
        if (state.status == 200) {
          challengeBloc(context).add(OnLoadingChallenge(user: state.user!));
        }
        return state.initialScreen == 0 ? SignIn() : _waiting();
      },
    );
  }
}

Widget _waiting() {
  return Scaffold();
}
