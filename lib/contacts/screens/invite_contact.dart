// import 'package:application_challenge/authentification/bloc/authentification_bloc.dart';
// import 'package:application_challenge/challenge/bloc/challenge_bloc.dart';
// import 'package:application_challenge/contacts/bloc/contact_bloc.dart';
// import 'package:application_challenge/contacts/screens/contact.dart';
// import 'package:application_challenge/contacts/screens/views/contact_item.dart';
// import 'package:application_challenge/widgets/header/contact_header.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:eva_icons_flutter/eva_icons_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';

// import '../../bloc.dart';

// class InviteContact extends StatefulWidget {
//   InviteContact({Key? key}) : super(key: key);

//   @override
//   _InviteContactsState createState() => _InviteContactsState();
// }

// class _InviteContactsState extends State<InviteContact> {
//   final _formKey = GlobalKey<FormState>();
//   CollectionReference documentReference =
//       FirebaseFirestore.instance.collection('contacts');

//   @override
//   void initState() {
//     super.initState();
//     getFollowings();
//   }

//   getFollowings() {
//     BlocProvider.of<ContactBloc>(context).add(OnLoadingFollowings(
//         currentUserId: authentificationBloc(context).state.user!.email!));
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Map _challenge =
//     //     BlocProvider.of<ChallengeBloc>(context, listen: true).state.challenges;

//     return Scaffold(
//         extendBody: false,
//         appBar: _contactAppBar(context),
//         body: Stack(
//           alignment: Alignment.topCenter,
//           children: [
//             Align(
//               alignment: Alignment.topCenter,
//               child: SingleChildScrollView(
//                 child: BlocBuilder<ContactBloc, ContactState>(
//                   builder: (context, state) {
//                     return Column(
//                       children: [
//                         Flex(
//                           direction: Axis.vertical,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           textDirection: TextDirection.ltr,
//                           children: <Widget>[
//                             _head(context),
//                             state.contact["searching"]
//                                 ? _searchUserWidget(context,
//                                     users: state.contact['results'])
//                                 : SizedBox(),
//                             // state.contact["loading"] || _challenge['loading']
//                             //     ? Center(child: Center(child: updateLoader()))
//                             //     : (state.contact["searching"]
//                             //         ? SizedBox()
//                             //         : _contactData(context, state: state))
//                           ],
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: _floatingButton(context),
//             )
//           ],
//         ));
//   }
// }

// Widget _head(context) {
//   return Container(
//     width: MediaQuery.of(context).size.width,
//     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//     child: Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: Text(
//         'Seuls les personnes invitées verront ce challenge. Veuillez inviter au moins une personne.',
//         style: Theme.of(context).textTheme.bodyText1!.copyWith(
//               color: Colors.blueGrey,
//               fontSize: 14,
//               fontWeight: FontWeight.w500,
//             ),
//         softWrap: true,
//         textAlign: TextAlign.center,
//       ),
//     ),
//   );
// }

// PreferredSize _contactAppBar(context) {
//   return PreferredSize(
//     preferredSize: Size.fromHeight(60),
//     child: BlocBuilder<ChallengeBloc, ChallengeState>(
//       builder: (context, state) {
//         return ContactHeader(
//           titleScreen: 'Inviter des contacts',
//           // key: _formKey,
//           // contactList: state.challenges['invitationList'],
//         );
//       },
//     ),
//   );
// }

// Widget _contactData(context, {required ContactState state}) {
//   List _followings = state.contact["followings"];
//   Size size = MediaQuery.of(context).size;
//   return Container(
//       width: size.width,
//       padding: EdgeInsets.symmetric(horizontal: 20),
//       child: _followings.length > 0
//           ? _contactList(context, followings: _followings)
//           : _noFollowingsFound());
// }

// Widget _contactList(context, {required List followings}) {
//   return Column(
//       children: followings.map<Widget>((contact) {
//     return ContactItem(
//       contact: contact,
//       invitation: true,
//     );
//   }).toList());
// }

// Widget _noFollowingsFound() {
//   return Text(
//     'Pas de contacts, veuillez actualiser',
//   );
// }

// Widget _floatingButton(context) {
//   return GestureDetector(
//     onTap: () {
//       // challengeBloc.add(RefreshInvitationList());
//       Get.offAllNamed("/home");
//     },
//     child: Container(
//       alignment: Alignment.center,
//       width: MediaQuery.of(context).size.width,
//       height: 55,
//       decoration: BoxDecoration(
//         color: Colors.blue,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey,
//             offset: const Offset(
//               5.0,
//               5.0,
//             ),
//             blurRadius: 10.0,
//             spreadRadius: 2.0,
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(
//             'Terminé',
//             style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w600,
//                 ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

// Widget _searchUserWidget(context, {required List users}) {
//   // Map _challenge =
//   //     BlocProvider.of<ChallengeBloc>(context, listen: true).state.challenges;

//   return Container(
//     width: MediaQuery.of(context).size.width,
//     padding: EdgeInsets.symmetric(horizontal: 20),
//     child: Column(
//       children: [
//         // (_challenge['invitationError'] != null)
//         //     ? _invitationError(context)
//         //     : SizedBox(),
//         _searchInput(context),
//         _userData(context, users: users),
//         // Divider(height: 1, color: Colors.blueGrey)
//       ],
//     ),
//   );
// }

// Widget _invitationError(context) {
//   return Padding(
//     padding: EdgeInsets.all(20),
//     child: Text(
//       'Une invitation n\'a pas été bien envoyée.',
//       style: Theme.of(context).textTheme.bodyText1!.copyWith(
//             color: Colors.red,
//             fontSize: 13,
//           ),
//       textAlign: TextAlign.center,
//     ),
//   );
// }

// Widget _userData(context, {required List? users}) {
//   ContactState _state =
//       BlocProvider.of<ContactBloc>(context, listen: true).state;
//   String? _searchText = _state.contact['search'];
//   return (_searchText == null || _searchText.length == 0)
//       ? _searchNotice()
//       : (users!.length > 0
//           ? Column(
//               children: users.map<Widget>((user) {
//               return ContactItem(
//                 contact: user,
//                 invitation: true,
//               );
//             }).toList())
//           : _noUserFound(context, _state));
// }

// Widget _searchNotice() {
//   return Padding(
//     padding: const EdgeInsets.all(20),
//     child: Text('Recherchez une personne par son nom d\'utilisateur, pseudo.',
//         textAlign: TextAlign.center),
//   );
// }

// Widget _noUserFound(context, state) {
//   return Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       Padding(
//         padding: const EdgeInsets.all(20),
//         child: Text(
//           'Aucun resultat pour \"${state.contact['search']}\"',
//           style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                 color: Colors.grey,
//               ),
//         ),
//       ),
//       Icon(
//         EvaIcons.personRemoveOutline,
//         color: Colors.blueGrey,
//         size: 18,
//       ),
//     ],
//   );
// }

// Widget _searchInput(context) {
//   return Container(
//       child: Flex(
//     direction: Axis.horizontal,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       Expanded(flex: 3, child: _inputField(context)),
//       // Expanded(flex: 1, child: _suffixIcon()),
//     ],
//   ));
// }

// Widget _inputField(context) {
//   return TextFormField(
//     autofocus: true,
//     cursorColor: Colors.blue,
//     cursorHeight: 20,
//     maxLines: 1,
//     onChanged: (String value) {
//       BlocProvider.of<ContactBloc>(context)
//           .add(OnSearchFieldChange(text: value));
//     },
//     onEditingComplete: () {},
//     decoration: InputDecoration(
//       border: InputBorder.none,
//       hintText: "Saisir le pseudo...",
//       hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
//             color: Colors.blueGrey,
//             fontSize: 13,
//             fontWeight: FontWeight.w400,
//           ),
//       contentPadding: EdgeInsets.symmetric(horizontal: 10),
//       focusedBorder: InputBorder.none,
//     ),
//   );
// }

// // Widget _suffixIcon() {
// //   return IconButton(
// //       onPressed: () {},
// //       icon: Icon(
// //         EvaIcons.searchOutline,
// //         color: Colors.blue,
// //         size: 16,
// //       ));
// // }
