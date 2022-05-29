import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ChallengeNotification {
  String? userId;
  String? challengeId;
  String? challengeTitle;
  String? authorDisplayName;
  String? authorPhotoURL;

  ChallengeNotification(
      {this.userId,
      this.challengeId,
      this.challengeTitle,
      this.authorDisplayName,
      this.authorPhotoURL});

  CollectionReference notifications =
      FirebaseFirestore.instance.collection('notifications');

  Map<String, dynamic> toJson() => {
        'userId': this.userId,
        'challengeId': this.challengeId,
        'challengeTitle': this.challengeTitle,
        'authorDisplayName': this.authorDisplayName,
        'authorPhotoURL': this.authorPhotoURL,
      };

  Future<void> sendInvitation() async {
    notifications
        .add({
          "userId": this.userId,
          "challengeId": this.challengeId,
          "challengeTitle": this.challengeTitle,
          "authorDisplayName": this.authorDisplayName,
          "authorPhotoURL": this.authorPhotoURL,
          "date": DateTime.now()
        })
        .then((value) {})
        .catchError((onError) {
          Get.snackbar('Erreur', 'onError');
        });
  }
}
