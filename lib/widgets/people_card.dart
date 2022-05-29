import 'package:application_challenge/bloc.dart';
import 'package:application_challenge/people/bloc/people_bloc.dart';
import 'package:application_challenge/people/screen/people_profile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget peopleCard(context, user) {
  return ListTile(
    onTap: () {
      peopleBloc(context).add(SeeProfile(people: user));
      Get.to(PeopleProfile(user: user));
    },
    leading: Container(
      width: 40,
      height: 40,
      child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: user['photoURL'],
          imageBuilder: (context, imageProvider) => CircleAvatar(
                backgroundImage: imageProvider,
              )),
    ),
    title: RichText(
      text: TextSpan(
        text: '${user['displayName']}',
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
      ),
    ),
  );
}
