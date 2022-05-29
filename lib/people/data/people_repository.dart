import 'dart:io';

import 'package:application_challenge/challenge/data/challenge_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PeopleRepository {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  CollectionReference followers =
      FirebaseFirestore.instance.collection('followers');

  CollectionReference followings =
      FirebaseFirestore.instance.collection('followings');

  CollectionReference challenges =
      FirebaseFirestore.instance.collection('challenge');

  Future<List?> getPeoples() async {
    try {
      var snapshot = await users.get();
      List? data = [];
      snapshot.docs.forEach((DocumentSnapshot e) {
        var _data = e.data() as Map<String, dynamic>;
        _data['id'] = e.id;
        data.add(_data);
      });

      return data;
    } catch (e) {
      return null;
    }
  }

  Future<List?> getFollowers(userId) async {
    try {
      var snapshot = await followers.doc(userId).get();
      Map data = snapshot.data() as Map;
      return data['followers'];
    } catch (e) {
      return [];
    }
  }

  Future<List?> getFollowings(userId) async {
    try {
      var snapshot = await followings.doc(userId).get();
      Map data = snapshot.data() as Map;
      return data['followings'];
    } catch (e) {
      return [];
    }
  }

  Future<List?> getChallenges(userId) async {
    try {
      var snapshot = await challenges.get();

      List? data = [];

      snapshot.docs.forEach((e) {
        var _data = e.data() as Map<String, dynamic>;
        if (_data['user']['id'] == userId) {
          _data['id'] = e.id;
          data.add(_data);
        }
      });
      return data;
    } catch (e) {
      print('****************** error $e');
      return [];
    }
  }

  Future<bool?> toggleFollow({
    required String docId,
    required Map user,
  }) async {
    try {
      DocumentSnapshot<Object?> snapshot =
          await this.followers.doc(docId).get();

      if (!snapshot.exists) {
        await this.followers.doc(docId).set({
          'followers': [user]
        });
        return false;
      }

      Map<String, dynamic> _follows = snapshot.data() as Map<String, dynamic>;
      List userFollowers = _follows['followers'] as List;

      bool theUserIsFollowers = false;

      userFollowers.forEach((element) {
        theUserIsFollowers = user['id'] == element['id'] ? true : false;
      });

      List? newFollowersList = [...userFollowers, user];

      if (theUserIsFollowers) {
        newFollowersList = userFollowers
            .where((element) => element['id'] != user['id'])
            .toList();
      }

      await this.followers.doc(docId).update({'followers': newFollowersList});
    } catch (e) {
      return false;
    }
  }

  Future<bool?> toggleFollowing({
    required String docId,
    required Map user,
  }) async {
    try {
      DocumentSnapshot<Object?> snapshot =
          await this.followings.doc(docId).get();

      if (!snapshot.exists) {
        await this.followings.doc(docId).set({
          'followings': [user]
        });
        return false;
      }

      Map<String, dynamic> _follows = snapshot.data() as Map<String, dynamic>;
      List userFollowers = _follows['followings'] as List;

      bool theUserIsFollowers = false;

      userFollowers.forEach((element) {
        theUserIsFollowers = user['id'] == element['id'] ? true : false;
      });

      List? newFollowersList = [...userFollowers, user];

      if (theUserIsFollowers) {
        newFollowersList = userFollowers
            .where((element) => element['id'] != user['id'])
            .toList();
      }

      await this.followings.doc(docId).update({'followings': newFollowersList});

      // if (userFollowers.isNotEmpty &&
      //     userFollowers
      //             .firstWhere((element) => element['id'] == user['id'])
      //             .length >
      //         0) {
      //   await this.followings.doc(docId).update(
      //     {
      //       'followings': userFollowers
      //           .where((element) => element['id'] != user['id'])
      //           .toList()
      //     },
      //   );
      // } else {
      //   await this.followings.doc(docId).update(
      //     {
      //       'followings': [...userFollowers, user]
      //     },
      //   );
      // }
    } catch (e) {
      return false;
    }
  }
}
