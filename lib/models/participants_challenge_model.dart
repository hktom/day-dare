import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ParticipantsChallengeModel {
  String? idChallenge;
  String? idChallenger;
  String? displayNameChallenger;
  String? imageProfilURL;
  String? imageURL;
  String? comment;

  ParticipantsChallengeModel({
    // required this.idChallenge,
    required this.idChallenger,
    required this.displayNameChallenger,
    required this.imageProfilURL,
    this.imageURL,
    this.comment,
  });

  static CollectionReference participants =
      FirebaseFirestore.instance.collection('participants');

  static CollectionReference challenge =
      FirebaseFirestore.instance.collection('challenge');

  Future<void> createParticipantsReference(BuildContext context) async {
    await participants.add({
      "idChallenge": this.idChallenge,
      "listChallengers": [
        {
          "idChallenger": this.idChallenger,
          "displayNameChallenger": this.displayNameChallenger,
          "imageProfilURL": this.imageProfilURL,
          "imageChallengeURL": this.imageURL,
          "comment": this.comment,
        }
      ],
      "comments": [],
    }).then((value) {
      // Navigator.of(context).pop();
      // return Get.to(RouteStack());
    }).catchError((onError) {
      // Navigator.of(context).pop();
      Get.snackbar('Error', '$onError');
      return null;
    });
  }

  // Future<void> addNewParticipant(BuildContext context,
  //     {String? refListParticipants, List? newListParticipants}) async {
  //   await participants
  //       .doc(refListParticipants)
  //       .update({'listChallengers': newListParticipants}).then((value) {
  //     Navigator.of(context).pop();
  //     Get.to(MesChallenges());
  //   }).catchError((onError) {
  //     Navigator.of(context).pop();
  //     return null;
  //   });
  // }

  Future<void> addNewParticipant(BuildContext context,
      {String? challengeId, List? newListParticipants}) async {
    await challenge
        .doc(challengeId)
        .update({'listChallengers': newListParticipants})
        .then((value) {})
        .catchError((onError) {
          return Get.snackbar("", "Une erreur est survenue lors de l'envoie");
        });
  }

  Future<void> addNewComment(BuildContext context,
      {String? refListParticipants, List? newListComments}) async {
    await participants
        .doc(refListParticipants)
        .update({'comments': newListComments}).then((data) {
      Navigator.of(context).pop();
    }).catchError((onError) {
      Navigator.of(context).pop();
      Get.snackbar('Error', '$onError');
      return null;
    });
  }

  static Future<List> getParticipantsList(BuildContext context,
          {String? refListParticipants}) async =>
      await participants
          .where('idChallenge', isEqualTo: refListParticipants)
          .get()
          .then((data) {
        return data.docs[0]["listChallengers"];
      }).catchError((onError) {
        return null;
      });
}
