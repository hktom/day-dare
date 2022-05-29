import 'package:cloud_firestore/cloud_firestore.dart';

class ChallengeRepository {
  var challengeRef = FirebaseFirestore.instance.collection('challenge');

  var commentsRef = FirebaseFirestore.instance.collection('comments');

  var likesRef = FirebaseFirestore.instance.collection('likes');

  var challengeUsersRef =
      FirebaseFirestore.instance.collection('challengeUsers');

  Future<List?> getChallenges() async {
    try {
      var value =
          await this.challengeRef.orderBy('date', descending: true).get();

      List data = [];
      value.docs.forEach((DocumentSnapshot e) {
        var _data = e.data() as Map<String, dynamic>;
        _data['id'] = e.id;
        data.add(_data);
      });

      return data;
    } catch (e) {
      print("get challenge error ${e.toString()}");
      return null;
    }
  }

  Future<List?> getChildChallenges(String challengeId) async {
    try {
      var value = await this.challengeUsersRef.doc(challengeId).get();
      Map data = value.data() as Map<String, dynamic>;
      return data['challengeUsers'];
    } catch (e) {
      print("get challenge error ${e.toString()}");
      return null;
    }
  }

  Future<List?> getParticipatedChallenges(String userEmail) async {
    try {
      List _challenges = [];
      var value = await this.challengeUsersRef.get();
      value.docs.forEach((element) {
        Map _value = element.data();

        _value['challengeUsers'].forEach((e) {
          if (e['user']['id'] == userEmail) {
            _challenges.add(e['fromChallenge']);
          }
        });
      });

      return _challenges;
    } catch (e) {
      print("*********** get challenge error ${e.toString()}");
      return null;
    }
  }

  Future<bool> joinChallenge(
      {required Map fromChallenge,
      required Map challenge,
      required Map user,
      required String? imageURL,
      required String? videoURL}) async {
    Map<String, dynamic> _payload = {
      ...challenge,
      'id': user['id'] +
          '' +
          fromChallenge['id'] +
          DateTime.now().toUtc().toString(),
      'userId': user['id'],
      'user': user,
      'date': DateTime.now(),
      'photoURL': imageURL,
      'videoURL': videoURL,
      'fromChallenge': fromChallenge,
    };

    try {
      DocumentSnapshot<Object?> snapshot =
          await this.challengeUsersRef.doc(fromChallenge['id']).get();

      if (!snapshot.exists) {
        await this.challengeUsersRef.doc(fromChallenge['id']).set({
          'challengeUsers': [_payload].toList()
        });
        return true;
      }

      Map<String, dynamic> _challengeUsers =
          snapshot.data() as Map<String, dynamic>;

      await this.challengeUsersRef.doc(fromChallenge['id']).update({
        'challengeUsers':
            [..._challengeUsers['challengeUsers'], _payload].toList()
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String?> postChallenge(
      {required Map challenge,
      required Map user,
      required String? imageURL,
      required String? videoURL}) async {
    Map<String, dynamic> _payload = {
      ...challenge,
      'user': user,
      'date': DateTime.now(),
      'photoURL': imageURL,
      'videoURL': videoURL,
      'duration': int.parse(challenge["duration"]!.split(' ')[0]),
    };

    if (challenge['groupe'] != null)
      _payload['groupe'] = [..._payload['groupe'], user];

    try {
      DocumentReference _challengeRef = await this.challengeRef.add(_payload);

      return _challengeRef.id;
    } catch (e) {
      return null;
    }
  }

  Future<bool?> toggleLikeChallenge({
    required String challengeId,
    required String uid,
  }) async {
    try {
      DocumentSnapshot<Object?> snapshot =
          await this.likesRef.doc(challengeId).get();

      if (!snapshot.exists) {
        await this.likesRef.doc(challengeId).set({
          'likes': [uid]
        });
        return false;
      }

      Map<String, dynamic> likes = snapshot.data() as Map<String, dynamic>;

      if (likes['likes'].contains(uid)) {
        await this.likesRef.doc(challengeId).update(
          {'likes': likes['likes'].where((element) => element != uid).toList()},
        );
      } else {
        await this.likesRef.doc(challengeId).update(
          {
            'likes': [...likes['likes'], uid]
          },
        );
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool?> postComments(
      {required Map user,
      required String docId,
      required String content}) async {
    try {
      Map _paylaod = {
        'user': user,
        'docId': docId,
        'content': content,
        'date': DateTime.now()
      };

      DocumentSnapshot<Object?> snapshot =
          await this.commentsRef.doc(docId).get();

      if (!snapshot.exists) {
        await this.commentsRef.doc(docId).set({
          'comments': [_paylaod].toList()
        });
        return true;
      }

      Map<String, dynamic> _comments = snapshot.data() as Map<String, dynamic>;

      await this.commentsRef.doc(docId).update({
        'comments': [..._comments['comments'], _paylaod].toList()
      });

      return true;
    } catch (e) {
      return false;
    }
  }
}

Duration getRemainingTime({required Timestamp date, required int duration}) {
  DateTime finalTime = date.toDate().add(new Duration(hours: duration));
  Duration remainingTime = finalTime.difference(DateTime.now());
  return remainingTime;
}

String formatRemainingTime({required Timestamp date, required int duration}) {
  Duration _duration = getRemainingTime(date: date, duration: duration);
  String elapsedTimes = getAvailablity(_duration); // rename elapsedTimes
  int hours = _duration.inHours;
  int minutes = _duration.inMinutes;

  if (elapsedTimes != '-')
    return (hours == 0) ? 'Il reste $minutes min' : 'Il reste $hours heure(s)';
  else
    return "${date.toDate().day}-${date.toDate().month}-${date.toDate().year} ${date.toDate().hour}:${date.toDate().minute}";
}

String getAvailablity(Duration duration) {
  return duration.toString()[0];
}
