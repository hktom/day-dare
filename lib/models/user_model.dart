import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserModel {
  String? id;
  String? displayName;
  String? email;
  String? photoURL;
  String? lastSeen;

  UserModel({
    required this.id,
    required this.displayName,
    required this.email,
    required this.photoURL,
  });

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  static CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  void setUserInfo({
    String? id,
    String? displayName,
    String? email,
    String? photoURL,
  }) {
    this.id = id;
    this.displayName = displayName;
    this.email = email;
    this.photoURL = photoURL;
  }

  void addUser() {
    users
        .doc(this.id)
        .set({
          'id': this.id,
          'displayName': this.displayName,
          'email': this.email,
          'photoURL': this.photoURL,
          'telephone': "",
        })
        .then((value) {})
        .catchError((onError) {
          Get.snackbar("Erreur", "$onError");
        });
  }

  static void updateUser({String? userAuthId, String? field, String? value}) {
    _users.doc(userAuthId.toString()).update({field!: value}).then((value) {
      if (field == "telephone")
        Get.snackbar("", "Numero mise à jour");
      else
        Get.snackbar("", "Nom utilisateur mise à jour");
    }).catchError((error) {
      Get.snackbar("Erreur", "$error");
    });
  }

  static void updateAvatar({String? userAuthId, String? avatarURL}) {
    _users
        .doc(userAuthId.toString())
        .update({'photoURL': avatarURL})
        .then((value) {})
        .catchError((error) {
          Get.snackbar('Erreur', '$error');
        });
  }

  static Future<QueryDocumentSnapshot> getUser({String? userId}) async =>
      await _users.where('id', isEqualTo: userId).get().then((data) {
        return data.docs[0];
      }).catchError((onError) {
        // ignore: return_of_invalid_type_from_catch_error
        return null;
      });

  static Future<List<QueryDocumentSnapshot<Object?>>> getAllUsers() async =>
      await _users.get().then((data) {
        return data.docs;
      }).catchError((onError) {
        // ignore: return_of_invalid_type_from_catch_error
        return null;
      });
}
