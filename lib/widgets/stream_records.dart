import 'package:application_challenge/challenge/bloc/challenge_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bloc.dart';

Widget streamLikes(context, challenge) {
  return _streamer(
    context,
    challenge: challenge,
    collection: 'likes',
    icon: EvaIcons.heart,
  );
}

Widget streamComments(context, challenge) {
  return _streamer(
    context,
    collection: 'comments',
    challenge: challenge,
    icon: EvaIcons.messageCircle,
  );
}

Widget streamChallengeUsers(context, challenge) {
  return _streamer(
    context,
    challenge: challenge,
    collection: 'challengeUsers',
    icon: EvaIcons.person,
  );
}

Widget _streamer(
  context, {
  required Map challenge,
  required String collection,
  required IconData icon,
}) {
  final Stream<QuerySnapshot> stream =
      FirebaseFirestore.instance.collection(collection).snapshots();

  return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError ||
            snapshot.connectionState == ConnectionState.waiting) {
          return _iconRow(
            context,
            collection: collection,
            challenge: challenge,
            color: Colors.blueGrey,
            icon: icon,
            count: '0',
          );
        }

        Map document = {};

        snapshot.data!.docs.forEach((element) {
          if (element.id == challenge['id']) document = element.data() as Map;
        });

        String userEmail = authentificationBloc(context).state.user!.email!;

        return _iconRow(
          context,
          collection: collection,
          challenge: challenge,
          color: document.isNotEmpty && document[collection].contains(userEmail)
              ? Colors.red
              : Colors.blueGrey,
          icon: icon,
          count: document.isNotEmpty
              ? document[collection].length.toString()
              : '0',
        );
      });
}

void _toggleLike(context, challenge) {
  challengeBloc(context).add(
    OnLikeChallenge(
        challengeId: challenge['id'],
        uid: authentificationBloc(context).state.user!.email!),
  );
}

void _seeChanlenge(context, challenge) {
  challengeBloc(context).add(SetPayload(payload: challenge));
  Get.toNamed("/single_challenge");
}

Widget _iconRow(
  context, {
  required Map challenge,
  required String collection,
  required IconData icon,
  required String count,
  required Color color,
}) {
  return InkWell(
    onTap: () {
      if (collection == 'likes') _toggleLike(context, challenge);
      if (collection == 'comments') _seeChanlenge(context, challenge);
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // hide count on zero
        Padding(
          padding: const EdgeInsets.only(right: 2),
          child: Text(
            count,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 14,
                  color: Colors.black,
                ),
          ),
        ),
        Icon(
          icon,
          color: color,
          size: 28,
        ),
      ],
    ),
  );
}

String _counter(int value) {
  if (value > 1000) return '${value}k';
  return value.toString();
}
