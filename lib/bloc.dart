import 'package:application_challenge/authentification/bloc/authentification_bloc.dart';
import 'package:application_challenge/people/bloc/people_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'challenge/bloc/challenge_bloc.dart';

AuthentificationBloc authentificationBloc(context) {
  return BlocProvider.of<AuthentificationBloc>(context);
}

ChallengeBloc challengeBloc(context) {
  return BlocProvider.of<ChallengeBloc>(context);
}

PeopleBloc peopleBloc(context) {
  return BlocProvider.of<PeopleBloc>(context);
}
