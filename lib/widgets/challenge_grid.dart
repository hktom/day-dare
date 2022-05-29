import 'package:application_challenge/challenge/bloc/challenge_bloc.dart';
import 'package:application_challenge/challenge/screens/child_challenge.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bloc.dart';

Widget challengeGrid({required context, required List? challenges}) {
  if (challenges == null || challenges.isEmpty) {
    return Center(
      child: Text("Aucun challenge trouvé"),
    );
  }

  var size = MediaQuery.of(context).size;
  final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
  final double itemWidth = size.width / 2.45;

  return GridView.count(
    shrinkWrap: true,
    childAspectRatio: (itemWidth / itemHeight),
    primary: false,
    padding: const EdgeInsets.all(20),
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
    crossAxisCount: 3,
    children: challenges
        .map((challenge) => challengeArchiveCard(context, challenge: challenge))
        .toList(),
  );
}

Widget challengeArchiveCard(context, {Map? challenge}) {
  return Container(
    width: 190,
    child: InkWell(
      onTap: () {
        // challengeBloc(context).add(SetPayload(payload: challenge!));
        Get.to(ChildChallenge(challenge: challenge!));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          imageCacheGrid(context, photoURL: challenge!["photoURL"]),
        ],
      ),
    ),
  );
}

Widget imageCacheGrid(context,
    {String? photoURL, double? width, double? height}) {
  return CachedNetworkImage(
    fit: BoxFit.cover,
    height: height ?? 180,
    width: width ?? 180,
    imageUrl: photoURL! /*"https://img.le-dictionnaire.com/paysage.jpg"*/,
    fadeOutDuration: Duration(milliseconds: 0),
    placeholder: (context, url) => Image(
      height: height ?? 180,
      width: width ?? 180,
      fit: BoxFit.cover,
      image: AssetImage('assets/images/placeholder.png'),
    ),
    errorWidget: (context, url, error) => Icon(Icons.error),
  );
}
