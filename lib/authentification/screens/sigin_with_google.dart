import 'package:application_challenge/authentification/bloc/authentification_bloc.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../bloc.dart';

Widget signInWithGoogle(BuildContext context,
    {Size? size, Function? setUserData, required String titleButton}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    child: SizedBox(
      height: 50,
      width: double.infinity,
      child: TextButton.icon(
        style: TextButton.styleFrom(backgroundColor: Colors.red),
        onPressed: () {
          var bloc = authentificationBloc(context);
          if (bloc.state.status == 100) return null;
          bloc.add(SignInWithGoogle());
        },
        icon: FaIcon(FontAwesomeIcons.google, color: Colors.white,),
        label: Text(
          titleButton,
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}