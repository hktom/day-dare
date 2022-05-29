import 'package:application_challenge/challenge/bloc/challenge_bloc.dart';
import 'package:application_challenge/challenge/screens/views/challenge_card.dart';
import 'package:application_challenge/challenge/screens/views/no_challenge_found.dart';
import 'package:application_challenge/people/bloc/people_bloc.dart';
import 'package:application_challenge/widgets/header/header_without_return_button.dart';
import 'package:application_challenge/widgets/people_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../bloc.dart';

class PeoplesList extends StatefulWidget {
  @override
  _PeoplesListState createState() => _PeoplesListState();
}

class _PeoplesListState extends State<PeoplesList>
    with AutomaticKeepAliveClientMixin {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    peopleBloc(context).add(GetPeoples());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey.withOpacity(.1),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: HeaderWithoutBackButton(
          titleScreen: 'Les amis',
          key: _formKey,
        ),
      ),
      body: BlocBuilder<PeopleBloc, PeopleState>(
        builder: (context, state) {
          if (state.peoples == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.peoples!.isEmpty) {
            return placeHolder(context);
          }
          return _scrollChallengeData(
            context,
            peoples: state.peoples,
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

Widget _scrollChallengeData(context, {required List? peoples}) {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  return SmartRefresher(
    onRefresh: () async {
      peopleBloc(context).add(GetPeoples());
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
        children: peoples!.map((items) {
          return peopleCard(context, items);
        }).toList(),
      ),
    ),
  );
}
