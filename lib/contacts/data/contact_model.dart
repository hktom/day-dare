import 'package:cloud_firestore/cloud_firestore.dart';

class ContactModel {
  DateTime? date;
  Map? user;
  String? id;

  ContactModel({this.date, this.user, this.id});

  factory ContactModel.fromDocument(DocumentSnapshot document) {
    return ContactModel(
        id: document["id"], user: document["user"], date: document["date"]);
  }
  Map<String, dynamic> toJson() => {
        'id': this.id ?? {},
        'user': this.user ?? {},
        'date': this.date ?? {},
      };
}
