// import 'package:application_challenge/contacts/data/contact_model.dart';
// import 'package:contacts_service/contacts_service.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:share_plus/share_plus.dart';

// String? formatContactPhoneNumber({String? phoneNumber}) {
//   return phoneNumber!.split(' ').join();
// }

// // synchronize contacts phoneNumber
// Future<List?> getSynchronizedContact({List<Contact>? contactList, List? users}) async {
//   List? synchronizedContactList = [];

//   for (int i = 0; i < contactList!.length; i++) {
//     Contact contact = contactList.elementAt(i);

//     if (contact.phones!.length > 0) {
//       String? formatContactPhone =
//           formatContactPhoneNumber(phoneNumber: contact.phones!.first.value);

//       if (formatContactPhone!.length < 9) continue;
//       int? startIndex = formatContactPhone.length - 9;

//       for (int j = 0; j < users!.length; j++) {
//         if (users[j]!["phone"] != null) {
//           String? _formatUserPhone =
//               formatContactPhoneNumber(phoneNumber: users[j]!["phone"]);
//           if (_formatUserPhone!
//               .contains(formatContactPhone.substring(startIndex))) {
//             ContactModel? synchronizedContact = new ContactModel(
//               id: users[j]!["id"],
//               user: {
//                 "displayName": contact.displayName,
//                 "pseudo": users[j]!["displayName"]
//                 "photoURL": users[j]!["photoURL"],
//                 "phone": users[j]!["phone"],
//               },
//             );
//             synchronizedContactList.add(synchronizedContact.toJson());
//           }
//         }
//       }
//     }
//   }
//   return synchronizedContactList;
// }

// Future<List<Contact>?>? getContacts() async {
//   if (await Permission.contacts.request().isGranted) {
//     Iterable<Contact> contacts = await ContactsService.getContacts(
//       withThumbnails: false,
//       photoHighResolution: false,
//     );
//     return contacts.toList();
//   } else {
//     await Permission.contacts.request();
//     return null;
//   }
// }

// void onShareApp(context) async {
// final box = context.findRenderObject() as RenderBox?;
// await Share.share("Installez l'application ChallengeApp, crééez des defis insolites et participez à d'autres défis. https://flutter.dev/",
//           sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
// }

// bool? alreadyFollower({List? users, String? contactId}) {
//   List? check = users!.where((user) => user['id'] == contactId).toList();
//   return check.length > 0 ? true : false;
// }