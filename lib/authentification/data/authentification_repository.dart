import 'package:application_challenge/challenge/data/challenge_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthentificationRepository {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  ChallengeRepository challengeRepository = ChallengeRepository();

  static Future<Map?> getUser(userId) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      var value = await users.doc(userId).get();
      var data = value.data() as Map<String, dynamic>;
      return data;
    } catch (e) {}
  }

  Future<User?> checkUserAuth() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      return currentUser;
    }
    return null;
  }

  Future<bool> resetPassword({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<User?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print("error signin firebase ${e.toString()}");
      return null;
    }
  }

  Future<User?> createUserWithEmailAndPassword(
      {required String? email, required String password}) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!,
        password: password,
      );

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print("error firebase ${e.toString()}");
      return null;
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print("googleError ${e.toString()}");
      return null;
    }
  }

  Future<bool> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool?> createUserProfile({
    required User user,
    required Map profile,
  }) async {
    await users.doc(user.email).set({
      'id': user.email ?? '',
      'displayName': profile['name'] ?? 'No pseudo',
      'email': profile['email'],
      'photoURL': user.photoURL ??
          'https://firebasestorage.googleapis.com/v0/b/challenge-kd.appspot.com/o/images%2Favatar.png?alt=media&token=e61b0144-370e-4083-951d-942447a371b9',
    }).then((value) {
      return true;
    }).catchError((onError) {
      return false;
    });
  }

  Future<Map?> getUserProfile({required User userCredential}) async {
    try {
      DocumentSnapshot snapshot = await users.doc(userCredential.email).get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      return data;
    } catch (e) {
      return null;
    }
  }

  Future<bool> updateUser({required Map userInfos}) async {
    return users
        .doc(userInfos["id"])
        .update({...userInfos})
        .then((value) => true)
        .catchError((error) => false);
  }
}
