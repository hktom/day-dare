// import 'package:application_challenge/models/user_model.dart';
// import 'package:application_challenge/screens/contacts/single_contact_profil.dart';
// import 'package:flutter/material.dart';


// Widget singleContactItem(BuildContext context, {String? label, String? name}) {
//   return Container(
//     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//     child: InkWell(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) {
//               return SingleContactProfil();
//             },
//           ),
//         );
//       },
//       child: Row(
//         children: <Widget>[
//           // label
//           Container(
//             height: 47,
//             width: 47,
//             margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Theme.of(context).accentColor,
//             ),
//             child: Center(
//               child: Text(
//                 '$label',
//                 style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//               ),
//             ),
//           ),

//           // action text item
//           Text(
//             '$name',
//             style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                   color: Colors.black.withOpacity(.9),
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
