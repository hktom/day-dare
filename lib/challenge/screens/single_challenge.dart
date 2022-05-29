import 'package:application_challenge/widgets/commentList.dart';
import 'package:application_challenge/challenge/screens/views/challenge_card.dart';
import 'package:application_challenge/widgets/comment_edit.dart';
import 'package:application_challenge/challenge/bloc/challenge_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../bloc.dart';

class SingleChallenge extends StatefulWidget {
  SingleChallenge({Key? key}) : super(key: key);

  @override
  _SignleChallengeState createState() => _SignleChallengeState();
}

class _SignleChallengeState extends State<SingleChallenge> {
  ScrollController scrollController = ScrollController();
  TextEditingController controller = TextEditingController();

  // void _scrollToend() {
  //   scrollController.jumpTo(scrollController.position.maxScrollExtent + 80);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(
        context,
        'Détails du défis',
        challengeBloc(context).state.payload,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    child: commentsList(
                        context, challengeBloc(context).state.payload),
                  ),
                ),
                flex: 1),
            Expanded(
              flex: 0,
              child: _participateButton(
                  context, challengeBloc(context).state.payload),
            ),
            Expanded(
                child: Container(
                  child: CommentEditor(),
                ),
                flex: 0),
          ],
        ),
      ),
      // body: Stack(
      //   alignment: Alignment.topCenter,
      //   children: [
      //     Align(
      //       alignment: Alignment.topCenter,
      //       child: SingleChildScrollView(
      //         controller: scrollController,
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: <Widget>[
      //             // child challenge
      //             if (challengeBloc(context).state.payload!['fromChallenge'] !=
      //                 null)
      //               challengeChildCard(context,
      //                   showFullDescription: true,
      //                   challenge: challengeBloc(context).state.payload!,
      //                   showImage: true),

      //             if (challengeBloc(context).state.payload!['fromChallenge'] ==
      //                     null &&
      //                 challengeBloc(context).state.payload!['user']['id'] !=
      //                     authentificationBloc(context).state.user!.email &&
      //                 challengeBloc(context).state.payload!['valide'] != false)
      //               // button
      //               _participateButton(
      //                   context, challengeBloc(context).state.payload),

      //             commentsList(context, challengeBloc(context).state.payload,
      //                 _scrollToend),
      //             Divider(color: Colors.grey.shade300),
      //             SizedBox(height: 100)
      //           ],
      //         ),
      //       ),
      //     ),
      //     Align(
      //       alignment: Alignment.bottomCenter,
      //       child: CommentEditor(),
      //     ),
      //   ],
      // ),
    );
  }
}

bool _checkIfUserParticipated(List document, user) {
  var check = false;
  document.forEach((element) {
    if (element['user']['id'] == user['id']) check = true;
  });
  return check;
}

Widget _participateButton(context, challenge) {
  if (challengeBloc(context).state.payload!['fromChallenge'] != null) {
    return SizedBox.shrink();
  }

  if (challengeBloc(context).state.payload!['valide'] == false) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "#Challenge expiré",
        style: TextStyle(color: Colors.blue.shade400),
      ),
    );
  }

  if (challengeBloc(context).state.payload!['user']['id'] ==
      authentificationBloc(context).state.user!.email) {
    return SizedBox.shrink();
  }

  var bloc = challengeBloc(context);
  // List users = challenge['users'] ?? [];

  // if (users.contains(authentificationBloc(context).state.user!.email)) {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Text(
  //       "#Vous avez join ce challenge",
  //       style: TextStyle(color: Colors.blue.shade400),
  //     ),
  //   );
  // }

  final Stream<QuerySnapshot> stream =
      FirebaseFirestore.instance.collection('challengeUsers').snapshots();

  return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError ||
            snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox.shrink();
        }

        if (snapshot.data!.docs.isEmpty) {
          return _buttonJoin(context, challenge);
        }

        Map document = {};

        snapshot.data!.docs.forEach((element) {
          if (element.id == challenge['id']) document = element.data() as Map;
        });

        if (document.isEmpty) {
          return _buttonJoin(context, challenge);
        }

        if (_checkIfUserParticipated(document['challengeUsers'],
            authentificationBloc(context).state.userProfile)) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "#Vous avez join ce challenge",
              style: TextStyle(color: Colors.blue.shade400),
            ),
          );
        }

        return _buttonJoin(context, challenge);
      });
}

Widget _buttonJoin(context, challenge) {
  var bloc = challengeBloc(context);
  return TextButton(
    onPressed: () {
      bloc.add(OnClickJoinButton(fromChallenge: challenge));
      Get.toNamed('/create_challenge');
    },
    child: Container(
      color: Colors.red,
      padding: EdgeInsets.all(10),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          "Participer au challenge",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}

AppBar _appbar(context, titleScreen, challenge) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 2,
    leading: IconButton(
      onPressed: () => Get.back(),
      icon: Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
    ),
    title: Text(
      titleScreen,
      style: Theme.of(context).textTheme.headline6,
    ),
    actions: [
      if (challenge['fromChallenge'] == null)
        IconButton(
          tooltip: 'Notifications',
          icon: Icon(
            Icons.dashboard_customize,
            color: Colors.black.withOpacity(.8),
          ),
          onPressed: () {
            Get.toNamed("/challenge_gallery", arguments: challenge);
          },
        ),
    ],
  );
}
