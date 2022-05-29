import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ContactModel {
  String? id;
  String? displayName;
  String? photoURL;
  String? phone;
  String? email;

  ContactModel(
      {this.id, this.displayName, this.photoURL, this.phone, this.email});

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'displayName': this.displayName,
        'photoURL': this.photoURL,
        'phone': this.phone,
        'email': this.email,
      };

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id'] as String?,
      displayName: json['displayName'] as String?,
      photoURL: json['photoURL'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
    );
  }

  static CollectionReference _contacts =
      FirebaseFirestore.instance.collection('contacts');

  static Future<QueryDocumentSnapshot> getAllContacts(
          {String? userAuthId}) async =>
      await _contacts.where("userId", isEqualTo: userAuthId).get().then((data) {
        return data.docs[0];
      }).catchError((onError) {
        // ignore: return_of_invalid_type_from_catch_error
        return null;
      });

  static void updateContact({String? contactListRef, List? contactList}) {
    _contacts
        .doc(contactListRef)
        .update({"contactList": contactList})
        .then((value) {})
        .catchError((onError) {
          Get.snackbar("Erreur", "$onError");
        });
  }

  static Future<void> createContactList(
      {String? userId, List? contactList}) async {
    print('create list. userid: $userId');
    await _contacts.doc(userId).set({
      'userId': userId,
      'contactList': contactList,
    }).then((value) {
      print("ContactsList Added");
      // Navigator.pop(context);
    }).catchError((error) {
      // Navigator.pop(context);
      Get.snackbar("", "$error");
      print("Failed to add contactslist: $error");
    });
  }

  // static void createContactList(BuildContext context,
  //     {String? userId, List? contactList}) {
  //   print('create contact list');
  //   _contacts
  //   .doc(userId.toString())
  //   .set({
  //     'userId': userId.toString(),
  //     'contactList': contactList!.toList(),
  //     'synchronizedContactList': [],
  //   })
  //   .then((value) {
  //     print("contact list added");
  //     Navigator.pop(context);
  //   })
  //   .catchError((error) {
  //     Navigator.pop(context);
  //     print("erreur: $error");
  //     Get.snackbar("", "$error");
  //   });
  // }

  //TODO: synchronize contact list
}
