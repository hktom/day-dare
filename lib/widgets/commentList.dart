import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

Widget commentsList(context, challenge) {
  Stream<QuerySnapshot> _streams =
      FirebaseFirestore.instance.collection('comments').snapshots();

  return StreamBuilder<QuerySnapshot>(
    stream: _streams,
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting ||
          snapshot.hasError) {
        return Container();
      }

      Map<String, dynamic> data = {};

      snapshot.data!.docs.forEach((element) {
        if (element.id == challenge['id'])
          data = element.data() as Map<String, dynamic>;
      });

      if (data.isEmpty) {
        return Container();
      }

      // _scrollToend();
      return Column(
        children: data['comments'].map<Widget>((element) {
          return _commentItem(context, element);
        }).toList(),
      );
    },
  );
}

Widget _commentItem(context, Map data) {
  var _streams = FirebaseFirestore.instance
      .collection('users')
      .doc(data['user']['id'])
      .snapshots();

  return StreamBuilder<DocumentSnapshot>(
      stream: _streams,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.hasError) {
          return Container();
        }

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(
              color: Colors.black54,
              width: 0.1,
            ),
          )),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            leading: CachedNetworkImage(
              height: 50,
              width: 50,
              fit: BoxFit.cover,
              imageUrl: snapshot.data!["photoURL"],
              imageBuilder: (context, imageProvider) => CircleAvatar(
                backgroundImage: imageProvider,
                backgroundColor: Colors.white,
              ),
            ),
            title: _details(context,
                date: data['date'],
                name: snapshot.data!['displayName'],
                comment: data['content']),
            horizontalTitleGap: 10,
          ),
        );
      });
}

Widget _details(
  context, {
  required Timestamp date,
  required String name,
  String? comment,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      nameItem(context, name: name, comment: comment),
      dateItem(context, date: date),
    ],
  );
}

Widget dateItem(context, {required Timestamp date}) {
  timeago.setLocaleMessages('fr', timeago.FrMessages());
  DateTime _date = date.toDate();
  final _loadedTime = new DateTime.now();
  final _difference = _loadedTime.difference(_date);

  return Padding(
    padding: const EdgeInsets.only(left: 10),
    child: Text(timeago.format(_loadedTime.subtract(_difference), locale: 'fr'),
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            )),
  );
}

Widget nameItem(context, {required String name, String? comment}) {
  return RichText(
    text: TextSpan(
        text: "@ $name ",
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.blueGrey,
            ),
        children: [
          TextSpan(
            text: comment,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
          ),
        ]),
  );
}
