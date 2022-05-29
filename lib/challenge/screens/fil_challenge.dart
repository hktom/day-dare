import 'package:application_challenge/challenge/bloc/challenge_bloc.dart';
import 'package:application_challenge/challenge/screens/views/challenge_card.dart';
import 'package:application_challenge/challenge/screens/views/no_challenge_found.dart';
import 'package:application_challenge/widgets/header/header_without_return_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../bloc.dart';

class FilChallenge extends StatefulWidget {
  @override
  _FilChallengeState createState() => _FilChallengeState();
}

class _FilChallengeState extends State<FilChallenge>
    with AutomaticKeepAliveClientMixin {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey.withOpacity(.1),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: HeaderWithoutBackButton(
          titleScreen: 'Accueil',
          key: _formKey,
        ),
      ),
      body: BlocBuilder<ChallengeBloc, ChallengeState>(
        builder: (context, state) {
          if (state.onGoing == null && state.private == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.onGoing!.isEmpty && state.private!.isEmpty) {
            return placeHolder(context);
          }
          return _scrollChallengeData(
            context,
            challenges: [...state.private!, ...state.onGoing!],
            progression: state.progression,
          );
        },
      ),
    );
  }
}

Widget placeHolder(context) {
  return noChallengeFound(
    context,
    infos: "Aucun challange en cours",
    icon: Icons.follow_the_signs_outlined,
    iconColor: Colors.blueAccent,
  );
}

Widget _scrollChallengeData(context,
    {required List? challenges, required bool? progression}) {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  return SmartRefresher(
    onRefresh: () async {
      challengeBloc(context).add(
        OnLoadingChallenge(user: authentificationBloc(context).state.user!),
      );
      _refreshController.refreshCompleted();
    },
    onLoading: () async {
      challengeBloc(context).add(OnLoadMoreChallenge());
      _refreshController.loadComplete();
    },
    controller: _refreshController,
    enablePullDown: true,
    enablePullUp: false,
    child: SingleChildScrollView(
      child: Column(
        children: [
          if (progression != null && progression == true)
            LinearProgressIndicator(),
          ...challenges!.map((items) {
            return challengeCard(
              context,
              challenge: items,
            );
          }).toList()
        ],
      ),
    ),
  );
}
