import 'package:application_challenge/bloc.dart';
import 'package:application_challenge/challenge/bloc/challenge_bloc.dart';
import 'package:application_challenge/widgets/challenge_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MesChallenges extends StatefulWidget {
  MesChallenges({Key? key}) : super(key: key);

  @override
  _MesChallengesState createState() => _MesChallengesState();
}

class _MesChallengesState extends State<MesChallenges>
    with AutomaticKeepAliveClientMixin {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // Size size = MediaQuery.of(context).size;

    challengeBloc(context).add(LoadParticipatedChallenge(
        userEmail: authentificationBloc(context).state.userProfile!['id']));

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: _appBar(context),
        body: BlocBuilder<ChallengeBloc, ChallengeState>(
          builder: (context, state) {
            print('****************** state ${state.participated}');
            return TabBarView(
              children: <Widget>[
                challengeGrid(context: context, challenges: state.expired),
                challengeGrid(context: context, challenges: state.participated),
              ],
            );
          },
        ),
      ),
    );
  }
}

AppBar _appBar(context) {
  return AppBar(
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            Color.fromRGBO(7, 91, 154, .9),
            Color.fromRGBO(20, 137, 253, .9),
          ],
        ),
      ),
    ),
    elevation: 1,
    toolbarHeight: 60,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ),
    title: Text(
      'Mes challenges',
      style: Theme.of(context).textTheme.headline6!.copyWith(
            color: Colors.white,
          ),
    ),
    bottom: TabBar(
      tabs: <Widget>[
        Tab(
          text: 'Terminés',
        ),
        Tab(
          text: 'Participés',
        ),
      ],
    ),
  );
}

int getDurationFromChallege(Map? challenge) {
  Map? _parentChallenge = challenge!['fromChallenge'];
  int? _duration = _parentChallenge!['duration'];
  while (_duration == null) {
    _parentChallenge = _parentChallenge!['fromChallenge'];
    _duration = _parentChallenge!['duration'];
  }
  return _duration;
}
