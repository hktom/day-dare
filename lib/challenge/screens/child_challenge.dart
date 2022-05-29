import 'package:application_challenge/challenge/screens/views/challenge_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChildChallenge extends StatefulWidget {
  final Map challenge;
  ChildChallenge({Key? key, required this.challenge}) : super(key: key);

  @override
  _ChildChallengeState createState() => _ChildChallengeState();
}

class _ChildChallengeState extends State<ChildChallenge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 40,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back, color: Colors.black,)),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: challengeCard(
            context,
            challenge: widget.challenge,
          ),
        ),
      ),
    );
  }
}
