import 'package:application_challenge/people/bloc/people_bloc.dart';
import 'package:application_challenge/people/screen/people_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc.dart';

class Profil extends StatefulWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    peopleBloc(context).add(
      SeeProfile(people: authentificationBloc(context).state.userProfile!),
    );

    return PeopleProfile(
      user: authentificationBloc(context).state.userProfile!,
    );
  }
}
