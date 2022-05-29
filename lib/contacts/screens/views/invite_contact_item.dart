// import 'package:application_challenge/authentification/bloc/authentification_bloc.dart';
// import 'package:application_challenge/challenge/bloc/challenge_bloc.dart';
// // import 'package:application_challenge/controller/challenge/invitation_controller.dart';
// // import 'package:application_challenge/user/bloc/user_bloc.dart';
// // import 'package:application_challenge/widgets/loader/invitation_loader.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// // ignore: must_be_immutable
// class InviteContactItem extends StatefulWidget {
//   InviteContactItem({
//     Key? key,
//     required this.contactId,
//     this.photoURL,
//     this.displayName,
//     this.userAuthId,
//     this.userAuthDisplayName,
//     this.userAuthPhotoURL,
//     this.challengeId,
//     this.challengeTitle,
//   }) : super(key: key);
//   String contactId;
//   String? photoURL;
//   String? displayName;
//   String? userAuthId;
//   String? userAuthDisplayName;
//   String? userAuthPhotoURL;
//   String? challengeId;
//   String? challengeTitle;

//   @override
//   _InviteContactItemState createState() => _InviteContactItemState();
// }

// class _InviteContactItemState extends State<InviteContactItem> {
//   // bool isSelected = false;
//   // bool isLoading = false;
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

//     return Container(
//       alignment: Alignment.centerLeft,
//       width: size.width,
//       padding: EdgeInsets.symmetric(vertical: 12),
//       child: Flex(direction: Axis.horizontal, children: [
//         // update icon
//         _userIcon(photoURL: widget.photoURL),

//         _userDisplayName(
//           context,
//           displayName: widget.displayName,
//         ),

//         _sendButton(
//           context,
//           contactId: widget.contactId,
//           setField: _setField,
//           fields: fields,
//         ),
//       ]),
//     );
//   }
// }

// Widget _userIcon({String? photoURL}) {
//   return Container(
//     height: 26,
//     width: 26,
//     child: ClipRRect(
//       borderRadius: BorderRadius.circular(50),
//       child: (photoURL != null && photoURL != "")
//           ? Image.network("$photoURL")
//           : Image.asset("assets/images/avatar.png"),
//     ),
//   );
// }

// Widget _userDisplayName(context, {String? displayName}) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 10),
//     child: Text(
//       '$displayName',
//       style: Theme.of(context).textTheme.bodyText1!.copyWith(
//             color: Colors.black,
//             fontSize: 16,
//           ),
//     ),
//   );
// }

// Widget _sendButton(context,
//     {required Map fields,
//     required String contactId,
//     required Function setField}) {
//   Map? challenge = challengeBloc.state.challenges;
//   Map? user =
//       authentificationBloc(context).state.user["currentUser"];
//   // var stateFields = fields ??
//   //     {
//   //       "isSelected": false,
//   //       "isLoading": false,
//   //     };
//   return Expanded(
//     child: Container(
//       alignment: Alignment.centerRight,
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(3),
//         child: fields["isSelected"]
//             ? _sended(context)
//             : Container(
//                 alignment: Alignment.center,
//                 height: 28,
//                 width: 90,
//                 color: Colors.blue,
//                 child: GestureDetector(
//                   onTap: () async {
//                     print('sending...');
//                     setField(
//                       field: "isLoading",
//                       value: true,
//                     );

//                     // await sendInvitation(
//                     //   userAuthId: "fff",
//                     //   userAuthDisplayName: user!["displayName"],
//                     //   userAuthPhotoURL: user["photoURL"],
//                     //   challengeId: challenge["fields"]["id"],
//                     //   challengeDescription: challenge["fields"]["description"],
//                     //   contactId: contactId,
//                     // ).then((value) {
//                     //   setField(
//                     //     field: "isSelected",
//                     //     value: true,
//                     //   );

//                     //   // context
//                     //   //     .read<InvitationStateProvider>()
//                     //   //     .addContact(
//                     //   //       contactId: widget.contactId
//                     //   //     );
//                     // }).catchError((onError) {
//                     //   setField(
//                     //     field: "isLoading",
//                     //     value: false,
//                     //   );
//                     // });

//                   },
//                   child: fields["isLoading"]
//                       ? CircularProgressIndicator()
//                       : Text(
//                           "Envoyer",
//                           style:
//                               Theme.of(context).textTheme.bodyText1!.copyWith(
//                                     fontSize: 12,
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                         ),
//                 ),
//               ),
//       ),
//     ),
//   );
// }

// Widget _sended(context) {
//   return Container(
//     alignment: Alignment.center,
//     height: 25,
//     width: 90,
//     decoration: BoxDecoration(
//       color: Colors.transparent,
//       border: Border.all(
//         width: 1,
//         color: Colors.blueGrey.withOpacity(.5),
//       ),
//     ),
//     child: Text(
//       "Envoyée",
//       style: Theme.of(context).textTheme.bodyText1!.copyWith(
//             fontSize: 12,
//             color: Colors.black,
//             fontWeight: FontWeight.w700,
//           ),
//     ),
//   );
// }
