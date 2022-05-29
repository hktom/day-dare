import 'package:cloud_firestore/cloud_firestore.dart';

class ContactRepository {
  CollectionReference userRef = FirebaseFirestore.instance.collection('users');
  Future<bool> addFollower(
      {required Map currentUser,
      required String currentUserId,
      required String contactId}) async {
    try {
      Map<String, dynamic> follower = {
        "id": currentUserId,
        "photoURL": currentUser["photoURL"],
        "displayName": currentUser["displayName"],
        "date": DateTime.now(),
      };
      await userRef
          .doc(contactId)
          .collection("followers")
          .doc(currentUserId)
          .set(follower);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addFollowing(
      {required Map contact,
      required String currentUserId,
      required String contactId}) async {
    try {
      Map<String, dynamic> followings = {
        "id": contactId,
        "photoURL": contact["user"]["photoURL"],
        "displayName": contact["user"]["pseudo"],
        "date": DateTime.now(),
      };
      await userRef
          .doc(currentUserId)
          .collection("followings")
          .doc(contactId)
          .set(followings);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List?> getUsers() async {
    try {
      QuerySnapshot<Object?> value = await this.userRef.get();

      List data = [];
      value.docs.forEach((DocumentSnapshot e) {
        var _data = e.data() as Map<String, dynamic>;
        _data['id'] = e.id;
        data.add(_data);
      });

      return data;
    } catch (e) {
      print("get users error ${e.toString()}");
      return null;
    }
  }

  Future<List?> getFollowings({String? currentUserId}) async {
    try {
      var followingsRef =
          await userRef.doc(currentUserId).collection("followings").get();
      List data = [];
      followingsRef.docs.forEach((DocumentSnapshot e) {
        var _data = e.data() as Map<String, dynamic>;
        _data['id'] = e.id;
        data.add(_data);
      });

      return data;
    } catch (e) {
      return null;
    }
  }

  Future<List?> getFollowers({String? currentUserId}) async {
    try {
      var followersRef =
          await userRef.doc(currentUserId).collection("followers").get();
      List data = [];
      followersRef.docs.forEach((DocumentSnapshot e) {
        var _data = e.data() as Map<String, dynamic>;
        _data['id'] = e.id;
        data.add(_data);
      });

      return data;
    } catch (e) {
      return null;
    }
  }
}
