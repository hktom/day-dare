import 'package:cloud_firestore/cloud_firestore.dart';

class FollowModel {
  String? idUser;
  List? followers;
  List? followings;

  static CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  static void addFollow({String? idUser}) {}

  static void getFollow({String? idUser}) {}

  static void addFollower({String? idUser, List? newListFollow}) {
    users
        .doc(idUser)
        .update({"followers": newListFollow})
        .then((value) => {
              print('new follower added'),
            })
        .catchError((onError) => {
              print('error to add follower: $onError'),
            });
  }

  static void addFollowing({String? idUser, List? newListFollow}) {
    users
        .doc(idUser)
        .update({"followings": newListFollow})
        .then((value) => {
              print('new following added'),
            })
        .catchError((onError) => {
              print('error to add following: $onError'),
            });
  }
}
