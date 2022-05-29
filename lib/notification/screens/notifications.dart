import 'package:application_challenge/authentification/bloc/authentification_bloc.dart';
// import 'package:application_challenge/challenge/data/challenge_model.dart';
// import 'package:application_challenge/challenge/data/challenge_repository.dart';
// import 'package:application_challenge/challenge/screens/single_challenge.dart';
import 'package:application_challenge/widgets/header/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../bloc.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthentificationState _state = authentificationBloc(context).state;
    String _userId = _state.user!.email!;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Header(
          titleScreen: 'Notifications',
          key: _formKey,
          hidden: true,
        ),
      ),
      body: Container(),
      // body: StreamBuilder(
      //     stream: FirebaseFirestore.instance
      //         .collection('users')
      //         .doc(_userId)
      //         .collection('notifications')
      //         .snapshots(),
      //     builder:
      //         (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      //       if (snapshot.hasError) {
      //         Text('Un probleme est survenu lors du chargement.');
      //       }

      //       if (snapshot.connectionState == ConnectionState.waiting) {
      //         return SizedBox(
      //             height: 200,
      //             child: Center(child: CircularProgressIndicator()));
      //       }

      //       List<QueryDocumentSnapshot<Object?>>? notifications =
      //           snapshot.data!.docs;

      //       // Widget listNotifications =
      //       //     _listNotification(context, notifications: notifications);

      //       // return (notifications.length > 0)
      //       //     ? listNotifications
      //       //     : emptyScreenNotification(context);
      //     }),
    );
  }
}

Widget emptyScreenNotification(BuildContext context) {
  return Container(
    color: Colors.grey.withOpacity(.1),
    child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 120,
            height: 120,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.blueGrey.shade100.withOpacity(.2),
            ),
            child: Icon(
              Icons.priority_high_outlined,
              color: Colors.black.withOpacity(.8),
              size: 45,
            ),
          ),
          Center(
              child: Text(
            "Vous n'avez pas des nouvelles notifications",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 15,
                  color: Colors.blueGrey,
                ),
            textAlign: TextAlign.center,
          )),
        ]),
  );
}

Widget displayNotificationItem(BuildContext context,
    {required String? expeditor,
    required String? challengeTitle,
    Timestamp? date}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      //User-Label
      Container(
        height: 40,
        width: 40,
        margin: EdgeInsets.fromLTRB(0, 0, 18, 0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blueAccent,
        ),
        child: Center(
          child: Text(
            (expeditor!.isNotEmpty) ? expeditor[0] : "?",
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),

      // Short description
      Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Clash of challenge
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Text(
                      "$expeditor vous a invité à un challenge. $challengeTitle.",
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  // Time elapsed
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 2.5, 0, 0),
                    child: Text(
                      "date",
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

// Widget _listNotification(context, {required List notifications}) {
//   return Column(
//       children: notifications.map((notification) {
//     return _notificationItem(context, notification: notification);
//   }).toList());
// }

// Widget _notificationItem(context, {required DocumentSnapshot notification}) {
//   var _challenge = ChallengeRepository.getChallengeById(
//       challengeId: notification['challengeId']);
//   var _streams = FirebaseFirestore.instance
//       .collection('users')
//       .doc(notification['expeditorId'])
//       .snapshots();
//   return StreamBuilder<DocumentSnapshot>(
//       stream: _streams,
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           // return networkError(context);
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//         Map<String, dynamic>? _user = {
//           "photoURL": snapshot.data!["photoURL"],
//           "displayName": snapshot.data!["displayName"],
//         };
//         return FutureBuilder<Object>(
//             future: _challenge,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 if (snapshot.hasError) {
//                   // return networkError(context);
//                 }

//                 Map<String, dynamic> _challenge =
//                     ChallengeModel.fromDocument(snapshot.data).toJson();
//                 _challenge["date"] = Timestamp.fromDate(_challenge['date']);
//                 _challenge["id"] = notification['challengeId'];

//                 return _notificationCard(context,
//                     user: _user,
//                     challenge: _challenge,
//                     notification: notification);
//               } else {
//                 return Container(
//                   alignment: Alignment.center,
//                   height: 15,
//                   width: 15,
//                   margin: EdgeInsets.symmetric(vertical: 20),
//                   child: CircularProgressIndicator(),
//                 );
//               }
//             });
//       });
// }

Widget _notificationCard(
  context, {
  required Map<String, dynamic> user,
  required DocumentSnapshot notification,
  required Map<String, dynamic> challenge,
}) {
  return InkWell(
    onTap: () {
      Get.toNamed("/single_challenge", arguments: challenge);
    },
    child: Container(
      padding: const EdgeInsets.all(20),
      child: Flex(
        direction: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _userIcon(photoURL: user['photoURL']),
          Flexible(
            child: _content(context,
                name: user['displayName'] ?? "inconnu",
                description: notification['challengeDescription'],
                date: notification['date']),
          ),
        ],
      ),
    ),
  );
}

Widget _content(context,
    {required String name,
    required String description,
    required Timestamp date}) {
  return Container(
    margin: EdgeInsets.only(left: 10),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                _name(context, name),
                _description(context, description),
              ],
            ),
          ),
          _date(context, date: date)
        ]),
  );
}

TextSpan _description(context, description) {
  return TextSpan(
      text:
          ' vous invite à un challenge. #${_truncationDescription(description)}',
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            color: Colors.black.withOpacity(.8),
          ));
}

TextSpan _name(context, String name) {
  return TextSpan(
      text: '@$name',
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            color: Colors.blue,
          ));
}

Widget _date(context, {required Timestamp date}) {
  timeago.setLocaleMessages('fr', timeago.FrMessages());
  DateTime _date = date.toDate();
  final _loadedTime = new DateTime.now();
  final _difference = _loadedTime.difference(_date);
  String _text =
      timeago.format(_loadedTime.subtract(_difference), locale: 'fr');
  return Padding(
    padding: const EdgeInsets.only(left: 10),
    child: Text(
      '_$_text',
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
      textAlign: TextAlign.left,
    ),
  );
}

Widget _userIcon({required String? photoURL}) {
  return Container(
    height: 30,
    width: 30,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: (photoURL != null && photoURL != "")
          ? Image.network("$photoURL")
          : Image.asset("assets/images/avatar.png"),
    ),
  );
}

String _truncationDescription(String description) {
  return (description.length < 20)
      ? description
      : "${description.substring(0, 20)}...";
}
