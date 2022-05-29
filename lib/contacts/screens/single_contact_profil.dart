// import 'package:application_challenge/controller/contact/follow_contact.dart';
// import 'package:application_challenge/controller/contact/profil_contact.dart';
// import 'package:application_challenge/widgets/contact/follow.dart';
// import 'package:application_challenge/widgets/contact/follow_button.dart';
// import 'package:application_challenge/widgets/header/profil_header.dart';
// import 'package:application_challenge/widgets/loader/secondary_loader.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

// // ignore: must_be_immutable
// class SingleContactProfil extends StatefulWidget {
//   SingleContactProfil(
//       {Key? key,
//       this.contactId,
//       this.contact,
//       this.displayName,
//       this.photoURL,
//       this.phone,
//       this.previousScreenChallenge})
//       : super(key: key);

//   String? photoURL;
//   String? displayName;
//   String? phone;
//   dynamic? contact;
//   String? contactId;
//   bool? previousScreenChallenge;

//   @override
//   _SingleContactProfilState createState() => _SingleContactProfilState();
// }

// class _SingleContactProfilState extends State<SingleContactProfil> {
//   String? phone = "";
//   DocumentSnapshot? contactUserInfos;
//   final _user = FirebaseFirestore.instance.collection('users');

//   @override
//   Widget build(BuildContext context) {
//     final box = GetStorage();
//     final userAuth = box.read('userId');
//     Size size = MediaQuery.of(context).size;

//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(60),
//         child: profilHeader(context),
//       ),
//       body: ListView(
//         children: [
//           // avatar
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
//             alignment: Alignment.center,
//             child: Container(
//               height: 90,
//               width: 90,
//               child: getAvatarContact(photoURL: widget.photoURL),
//             ),
//           ),

//           // display name
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 5),
//             child: Center(
//               child: Text(
//                 "${getContactDisplayName(defaultDisplayName: widget.displayName)}",
//                 style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                       fontSize: 17.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//               ),
//             ),
//           ),

//           // phone
//           Center(
//             child: getPhoneWidget(
//               context,
//               phone: widget.phone,
//               previousScreenChallenge: widget.previousScreenChallenge,
//             ),
//           ),

//           // followings & followers
//           StreamBuilder(
//             stream: FirebaseFirestore.instance
//                 .collection('users')
//                 .where('id', isEqualTo: "${widget.contactId}")
//                 .snapshots(),
//             builder:
//                 (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//               if (snapshot.hasError) {
//                 Text('Un probleme est survenu lors du chargement.');
//               }

//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return secondaryLoader();
//               }

//               // Map<String, dynamic> data =
//               //     snapshot.data!.data() as Map<String, dynamic>;

//               DocumentSnapshot? user = snapshot.data!.docs[0];

//               int? followers = getContactFollowers(
//                 followers: user["followers"],
//               );

//               int? followings = getContactFollowings(
//                 followings: user["followings"],
//               );

//               return Column(
//                 children: [
//                   // follow button
//                   followButton(context,
//                       alreadyFollower: getFollowerStatus(
//                         userAuthId: userAuth.toString(),
//                         followersList: user["followers"],
//                       ),
//                       onTap: () => {
//                             addFollowings(
//                               userAuthId: userAuth.toString(),
//                               contactUserInfos: user,
//                             ),
//                           }),

//                   // follow button
//                   Flex(
//                     direction: Axis.horizontal,
//                     children: [
//                       follow(
//                         context,
//                         follow: "Followers",
//                         count: "$followers",
//                         bkgColor: Colors.grey.withOpacity(.2),
//                       ),
//                       follow(
//                         context,
//                         follow: "Followings",
//                         count: "$followings",
//                         bkgColor: Colors.blueAccent.withOpacity(.2),
//                       ),
//                     ],
//                   )
//                 ],
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
