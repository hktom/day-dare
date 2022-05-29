// import 'package:application_challenge/authentification/bloc/authentification_bloc.dart';
// import 'package:application_challenge/challenge/bloc/challenge_bloc.dart';
// import 'package:application_challenge/contacts/bloc/contact_bloc.dart';
// import 'package:application_challenge/contacts/data/contact_controller.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';

// import '../../../bloc.dart';

// // ignore: must_be_immutable
// class ContactItem extends StatefulWidget {
//   ContactItem({
//     Key? key,
//     required this.contact,
//     this.invitation: false,
//   }) : super(key: key);

//   final Map contact;
//   final bool invitation;

//   @override
//   _ContactItemState createState() => _ContactItemState();
// }

// class _ContactItemState extends State<ContactItem> {
//   Map fields = {
//     "isSelected": false,
//     "isLoading": false,
//   };

//   _setField({required String field, required bool value}) {
//     setState(() {
//       this.fields[field] = value;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return BlocListener<ContactBloc, ContactState>(
//       listener: (context, state) {
//         if (state.contact["error"] != "")
//           Get.snackbar("", "Problème de conexion");
//       },
//       child: Container(
//         alignment: Alignment.centerLeft,
//         width: size.width,
//         padding: EdgeInsets.symmetric(vertical: 12),
//         // child: widget.invitation
//         //     ? _onInviteToChallenge(context,
//         //         contact: widget.contact,
//         //         fields: this.fields,
//         //         setField: this._setField)
//         //     : _onFollowContact(context,
//         //         contact: widget.contact,
//         //         fields: this.fields,
//         //         setField: this._setField),
//       ),
//     );
//   }
// }

// Widget _onFollowContact(context,
//     {required Function setField, required Map contact, required Map fields}) {
//   return ListTile(
//     horizontalTitleGap: 5,
//     trailing: _sendButton(context,
//         contact: contact, setField: setField, fields: fields),
//     contentPadding: EdgeInsets.symmetric(horizontal: 5),
//     leading: _userIcon(photoURL: contact["user"]["photoURL"]),
//     title:
//         _userDisplayName(context, displayName: contact["user"]["displayName"]),
//     subtitle: _pseudo(context, pseudo: contact["user"]["pseudo"]),
//   );
// }

// // Widget _onInviteToChallenge(context,
// //     {required Function setField,
// //     required dynamic contact,
// //     required Map fields}) {
// //   return ListTile(
// //     horizontalTitleGap: 5,
// //     trailing: _inviteButton(context,
// //         contact: contact, setField: setField, fields: fields),
// //     contentPadding: EdgeInsets.symmetric(horizontal: 5),
// //     leading: _userIcon(photoURL: contact["photoURL"]),
// //     title: _userDisplayName(context, displayName: contact["displayName"]),
// //   );
// // }

// Widget _userIcon({required String? photoURL}) {
//   return Container(
//     height: 30,
//     width: 30,
//     child: ClipRRect(
//       borderRadius: BorderRadius.circular(50),
//       child: (photoURL != null && photoURL != "")
//           ? Image.network("$photoURL")
//           : Image.asset("assets/images/avatar.png"),
//     ),
//   );
// }

// Widget _userDisplayName(context, {required String? displayName}) {
//   return Text(
//     '$displayName',
//     style: Theme.of(context).textTheme.bodyText1!.copyWith(
//           color: Colors.black,
//           fontSize: 16,
//         ),
//     textAlign: TextAlign.left,
//   );
// }

// Widget _sendButton(context,
//     {required Map contact, required Map fields, required Function setField}) {
//   List? users =
//       BlocProvider.of<ContactBloc>(context).state.contact["followings"];
//   bool? _checkFollowing =
//       alreadyFollower(users: users, contactId: contact["id"]);
//   return _checkFollowing!
//       ? _alreadyFollower(context)
//       : (fields["isSelected"]
//           ? _sended(context)
//           : _send(context,
//               contact: contact, fields: fields, setField: setField));
// }

// // Widget _inviteButton(context,
// //     {required dynamic contact,
// //     required Map fields,
// //     required Function setField}) {
// //   // Map? _challengeRef = challengeBloc(context).state.challenges;
// //   List? _invitedList = _challengeRef['invitationList'];
// //   bool? _checkInvited =
// //       alreadyInvited(invitedList: _invitedList, contactId: contact["id"]);

// //   return _checkInvited!
// //       ? _sended(context)
// //       : (fields["isSelected"]
// //           ? _sended(context)
// //           : _invite(context,
// //               contact: contact, fields: fields, setField: setField));
// // }

// bool? alreadyInvited({required List? invitedList, required String contactId}) {
//   if (invitedList!.contains(contactId)) return true;
//   return false;
// }

// // Widget _invite(context,
// //     {required Function setField,
// //     required dynamic contact,
// //     required Map fields}) {
// //   Map? _challengeRef = challengeBloc.state.challenges;
// //   String? _userId = authentificationBloc(context).state.user!.email;
// //   Map<String, dynamic> _currentUser = {
// //     "id": _userId,
// //     "displayName": authentificationBloc(context).state.user!.displayName,
// //     "photoURL": authentificationBloc(context).state.user!.photoURL
// //   };
// //   Map<String, dynamic> _challenge = {
// //     "id": _challengeRef['challengeId'],
// //     "description": _challengeRef["fields"]["description"],
// //   };

// //   return TextButton(
// //     style: ButtonStyle(
// //         animationDuration: Duration(milliseconds: 500),
// //         padding: MaterialStateProperty.all(
// //             EdgeInsets.symmetric(vertical: 5, horizontal: 20)),
// //         alignment: Alignment.center,
// //         backgroundColor: MaterialStateProperty.all(Colors.blue),
// //         overlayColor: MaterialStateProperty.all((Colors.grey.withOpacity(.2)))),
// //     onPressed: () async {
// //       setField(
// //         field: "isLoading",
// //         value: true,
// //       );
// //       print('send invitation');

// //       challengeBloc.add(OnInviteToChallenge(
// //           userId: contact["id"],
// //           challenge: _challenge,
// //           currentUser: _currentUser));

// //       await Future.delayed(Duration(milliseconds: 300));
// //       setField(
// //         field: "isSelected",
// //         value: true,
// //       );
// //     },
// //     child: fields["isLoading"]
// //         ? _invitationLoader()
// //         : Text(
// //             'Inviter',
// //             style: Theme.of(context).textTheme.bodyText1!.copyWith(
// //                   color: Colors.white,
// //                   fontWeight: FontWeight.w900,
// //                 ),
// //           ),
// //   );
// // }

// Widget _send(context,
//     {required Function setField, required Map contact, required Map fields}) {
//   return TextButton(
//     style: ButtonStyle(
//         animationDuration: Duration(milliseconds: 500),
//         padding: MaterialStateProperty.all(
//             EdgeInsets.symmetric(vertical: 5, horizontal: 20)),
//         alignment: Alignment.center,
//         backgroundColor: MaterialStateProperty.all(Colors.blue),
//         overlayColor: MaterialStateProperty.all((Colors.grey.withOpacity(.2)))),
//     onPressed: () async {
//       setField(
//         field: "isLoading",
//         value: true,
//       );
//       BlocProvider.of<ContactBloc>(context).add(
//         AddFollower(
//             currentUserId: authentificationBloc(context).state.user!.email!,
//             currentUser: authentificationBloc(context).state.userProfile!,
//             contactId: contact["id"]),
//       );
//       BlocProvider.of<ContactBloc>(context).add(
//         AddFollowing(
//             currentUserId: authentificationBloc(context).state.user!.email!,
//             contact: contact,
//             contactId: contact["id"]),
//       );
//       await Future.delayed(Duration(milliseconds: 1000));
//       setField(
//         field: "isSelected",
//         value: true,
//       );
//     },
//     child: fields["isLoading"]
//         ? _invitationLoader()
//         : Text(
//             'Suivre',
//             style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w900,
//                 ),
//           ),
//   );
// }

// Widget _sended(context) {
//   return TextButton(
//       style: ButtonStyle(
//           padding: MaterialStateProperty.all(
//               EdgeInsets.symmetric(vertical: 5, horizontal: 20)),
//           alignment: Alignment.center,
//           overlayColor:
//               MaterialStateProperty.all((Colors.grey.withOpacity(.2)))),
//       onPressed: () {},
//       child: Icon(Icons.done, color: Colors.blue, size: 14));
// }

// Widget _invitationLoader() {
//   return Container(
//     width: 14,
//     height: 14,
//     child: CircularProgressIndicator(
//       color: Colors.grey,
//       strokeWidth: 2,
//     ),
//   );
// }

// Widget _pseudo(context, {required String pseudo}) {
//   return Container(
//     child: Text(
//       pseudo,
//       style: Theme.of(context).textTheme.bodyText1!.copyWith(
//             fontSize: 12,
//             color: Colors.blueGrey,
//           ),
//       textAlign: TextAlign.left,
//       softWrap: true,
//     ),
//   );
// }

// Widget _alreadyFollower(context) {
//   return TextButton(
//       style: ButtonStyle(
//           side: MaterialStateProperty.all(BorderSide(
//             width: 1,
//             color: Colors.blue,
//           )),
//           padding: MaterialStateProperty.all(
//               EdgeInsets.symmetric(vertical: 5, horizontal: 20)),
//           alignment: Alignment.center,
//           overlayColor:
//               MaterialStateProperty.all((Colors.grey.withOpacity(.2)))),
//       onPressed: () {},
//       child: Text('suivi',
//           style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                 color: Colors.blue,
//                 fontWeight: FontWeight.w500,
//               )));
// }
