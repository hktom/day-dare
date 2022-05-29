import 'package:application_challenge/authentification/bloc/authentification_bloc.dart';
import 'package:application_challenge/challenge/bloc/challenge_bloc.dart';
// import 'package:application_challenge/user/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../bloc.dart';

Widget headerSecondary(BuildContext context,
    {String? titleScreen,
    Color? bkgColor,
    Color? titleColor,
    Color? iconColor,
    bool forceReturn: false,
    bool createChallengeScreen: false,
    double? elevation}) {
  return AppBar(
    backgroundColor: bkgColor,
    elevation: elevation,
    leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: iconColor,
          ),
          onPressed: () {
            Get.back();
          },
          tooltip: 'Retour',
        );
      },
    ),
    title: Text(
      titleScreen!,
      style: Theme.of(context).textTheme.headline6!.copyWith(
            color: titleColor,
            letterSpacing: .5,
          ),
    ),
    centerTitle: false,
    actions: [
      createChallengeScreen
          ? IconButton(
              tooltip: 'Créér',
              icon: Icon(
                Icons.done,
                color: Colors.yellowAccent,
              ),
              onPressed: () {
                // var state = challengeBloc(context).state.challenges;

                // if (state["fields"]["description"] == "" ||
                //     state["fields"]["description"] == null) {
                //   Get.snackbar("", "Mettez une description");
                //   return;
                // }

                // if (state['id'] != null || !state['privacy']) {
                //   challengeBloc.add(OnCreatingChallenge());
                //   Get.offAllNamed('/home');
                //   // Get.back();
                //   return;
                // }

                // challengeBloc.add(OnCreatingChallenge());
                // Get.toNamed("/invite_contact");
              },
            )
          : SizedBox(),
    ],
  );
}
