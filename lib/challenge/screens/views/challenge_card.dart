import 'package:application_challenge/challenge/bloc/challenge_bloc.dart';
import 'package:application_challenge/challenge/data/challenge_repository.dart';
import 'package:application_challenge/challenge/screens/mes_challenges.dart';
import 'package:application_challenge/challenge/screens/video_app.dart';
import 'package:application_challenge/widgets/stream_records.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
// import 'package:video_player/video_player.dart';
import '../../../bloc.dart';

Widget challengeCard(context,
    {required Map challenge,
    bool showImage: true,
    bool showFullDescription: false}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3),
    padding: EdgeInsets.only(bottom: 20),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(
        bottom: BorderSide(
          color: Colors.grey.withOpacity(.2),
          width: 1,
        ),
      ),
    ),
    child: Flex(
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _challengeAuthor(context, challenge: challenge),
        if (showImage)
          challenge['videoURL'] != null
              ? VideoAppPlayer(
                  videoURL: challenge['videoURL'],
                  photoURL: challenge['photoURL'])
              : _challengeImage(context,
                  photoURL: challenge["photoURL"], challenge: challenge),
        _challengeCardBottom(context, challenge: challenge),
        _challengeDescription(
            description: challenge["description"],
            showFullText: showFullDescription),
      ],
    ),
  );
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

Widget _challengeImage(
  context, {
  required String photoURL,
  required Map challenge,
}) {
  double imageHeight = 380;
  return GestureDetector(
    onDoubleTap: () => _toggleLike(context, challenge),
    onTap: () => _seeChanlenge(context, challenge),
    child: CachedNetworkImage(
      height: imageHeight,
      width: double.infinity,
      fit: BoxFit.cover,
      imageUrl: photoURL,
      fadeOutDuration: Duration(milliseconds: 0),
      placeholder: (context, url) => Image(
        height: imageHeight,
        width: double.infinity,
        fit: BoxFit.cover,
        image: AssetImage('assets/images/placeholder.png'),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    ),
  );
}

String _counter(int value) {
  if (value > 1000) return '${value}k';
  return value.toString();
}

Widget _challengeCardBottom(context, {required Map challenge}) {
  bool isChild = challenge['fromChallenge'] == null ? false : true;
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: streamLikes(context, challenge)),
        Expanded(child: streamComments(context, challenge)),
        if (!isChild) Expanded(child: streamChallengeUsers(context, challenge)),
        Expanded(
          child: !isChild
              ? _availablity(context, challenge: challenge)
              : Container(),
          flex: 2,
        )
      ],
    ),
  );
}

Widget _availablity(context, {required Map challenge}) {
  Duration _duration = getRemainingTime(
      date: challenge["date"],
      duration: challenge["duration"] != null
          ? challenge["duration"]
          : getDurationFromChallege(challenge));
  String _elapsedTimes = getAvailablity(_duration);

  return (_elapsedTimes != '-')
      ? Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.timer,
              color: Colors.blueGrey,
              size: 20,
            ),
            challenge['fromChallenge'] == null
                ? _time(challenge, context)
                : _time(challenge['fromChallenge'], context),
          ],
        )
      : _galleryIcon(challenge);
}

Widget _galleryIcon(Map challenge) {
  return Container(
    alignment: Alignment.centerRight,
    child: IconButton(
      tooltip: 'Notifications',
      icon: Icon(
        Icons.dashboard_customize,
        color: Colors.red,
        size: 16,
      ),
      onPressed: () {
        Get.toNamed("/challenge_gallery", arguments: challenge);
      },
    ),
  );
}

Widget _time(challenge, context) {
  return Text(
      formatRemainingTime(
        date: challenge["date"],
        duration: challenge["duration"] != null
            ? challenge["duration"]
            : getDurationFromChallege(challenge),
      ),
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            color: Colors.blue,
            fontSize: 11.0,
          ));
}

Widget _challengeAuthor(context, {required Map challenge}) {
  var _streams = FirebaseFirestore.instance
      .collection('users')
      .doc(challenge['user']!['id'])
      .snapshots();
  bool isPrivate = challenge['isPrivate'];
  return StreamBuilder<DocumentSnapshot>(
      stream: _streams,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.hasError) {
          return Container();
        }

        return ListTile(
          onTap: () {},
          leading: Container(
            width: 40,
            height: 40,
            child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: snapshot.data!["photoURL"],
                imageBuilder: (context, imageProvider) => CircleAvatar(
                      backgroundImage: imageProvider,
                    )),
          ),
          trailing:
              isPrivate ? Icon(Icons.privacy_tip, color: Colors.blue) : null,
          title: RichText(
            text: TextSpan(
              text: snapshot.data!["displayName"] ?? 'No Pseudo',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        );
      });
}

Widget _challengeDescription({String? description, bool? showFullText}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10),
    alignment: Alignment.centerLeft,
    child: Text(
      showFullText! ? "$description" : _truncation(text: description ?? ""),
      textAlign: TextAlign.left,
    ),
  );
}

String _truncation({required String text}) {
  return (text.length < 60) ? text : "${text.substring(0, 60)}...";
}
