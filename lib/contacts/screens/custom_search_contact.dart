// import 'package:application_challenge/widgets/header/search_header.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:search_page/search_page.dart';

// class Person {
//   final String name, surname;
//   final num age;

//   Person(this.name, this.surname, this.age);
// }

// class CustomSearchContact extends StatefulWidget {
//   static List<Person> people = [
//     Person('Mike', 'Barron', 64),
//     Person('Todd', 'Black', 30),
//     Person('Ahmad', 'Edwards', 55),
//     Person('Anthony', 'Johnson', 67),
//     Person('Annette', 'Brooks', 39),
//   ];
//   String? userAuthId;
//   CustomSearchContact({this.userAuthId});

//   @override
//   _CustomSearchContactState createState() => _CustomSearchContactState();
// }

// class _CustomSearchContactState extends State<CustomSearchContact> {
//   String? challengeId;
//   String? challengeTitle;
//   String? userAuthDisplayName;
//   String? userAuthPhotoURL;

//   CollectionReference documentReference =
//       FirebaseFirestore.instance.collection('contacts');

//   DocumentSnapshot<Object?>? _contacts;

//   final _formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     super.initState();
//     getContactsList();
//   }

//   Future<DocumentSnapshot<Object?>?> getContactsList() async {
//     await documentReference
//         .where('userId', isEqualTo: widget.userAuthId.toString())
//         .get()
//         .then((contacts) {
//       setState(() {
//         _contacts = contacts.docs[0];
//         print('challenge state: $contacts');
//       });

//       return contacts;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final box = GetStorage();
//     final userAuth = box.read('userId');
//     Size size = MediaQuery.of(context).size;

//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(60),
//         child: SearchHeader(
//           key: _formKey,
//           onTapSearchIcon: () => showSearch(
//             context: context,
//             delegate: SearchPage<Person>(
//               onQueryUpdate: (s) => print(s),
//               items: CustomSearchContact.people,
//               searchLabel: 'Search people',
//               suggestion: Center(
//                 child: Text('Filter people by name, surname or age'),
//               ),
//               failure: Center(
//                 child: Text('No person found :('),
//               ),
//               filter: (person) => [
//                 person.name,
//                 person.surname,
//                 person.age.toString(),
//               ],
//               builder: (person) => ListTile(
//                 title: Text(person.name),
//                 subtitle: Text(person.surname),
//                 trailing: Text('${person.age} yo'),
//               ),
//             ),
//           ),
//           onTapBackButton: () {
//             Get.back();
//           },
//         ),
//       ),
//       body: Container(
//         width: size.width,
//         padding: EdgeInsets.symmetric(horizontal: 20),
//         child: StreamBuilder(
//             stream: FirebaseFirestore.instance
//                 .collection('contacts')
//                 .where('userId', isEqualTo: userAuth.toString())
//                 .snapshots(),
//             builder:
//                 (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//               if (snapshot.hasError) {
//                 Text('Un probleme est survenu lors du chargement.');
//               }

//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 // return Center(child: secondaryLoader());
//               }

//               var contact = snapshot.data!.docs;
//               var contactList = contact[0]["contactList"];

//               print('contact: $contact');

//               return (contact.length == 0)
//                   ? Text('Pas de contacts, veuillez actualiser')
//                   : Column(
//                       children: contactList.map<Widget>((contact) {
//                       // return InviteContactItem(
//                       //   contactId: contact["id"],
//                       //   displayName: contact["displayName"],
//                       //   photoURL: contact["photoURL"],
//                       //   challengeId: challengeId,
//                       //   challengeTitle: challengeTitle,
//                       //   userAuthId: userAuth.toString(),
//                       //   userAuthDisplayName: userAuthDisplayName,
//                       //   userAuthPhotoURL: userAuthPhotoURL,
//                       // );
//                     }).toList());
//             }),
//       ),
//     );
//   }
// }
