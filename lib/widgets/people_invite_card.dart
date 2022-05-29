import 'package:application_challenge/bloc.dart';
import 'package:application_challenge/people/bloc/people_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PeopleInviteCard extends StatefulWidget {
  final Map user;
  PeopleInviteCard({Key? key, required this.user}) : super(key: key);

  @override
  _PeopleInviteCardState createState() => _PeopleInviteCardState();
}

class _PeopleInviteCardState extends State<PeopleInviteCard> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        setState(() {
          isCheck = !isCheck;
        });
        peopleBloc(context)
            .add(ToggleInvitation(payload: widget.user, toggle: isCheck));
      },
      leading: Container(
        width: 40,
        height: 40,
        child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: widget.user['photoURL'],
            imageBuilder: (context, imageProvider) => CircleAvatar(
                  backgroundImage: imageProvider,
                )),
      ),
      trailing: isCheck
          ? Icon(Icons.check_circle, color: Colors.green, size: 30)
          : Icon(Icons.check_circle_outlined, size: 30),
      title: RichText(
        text: TextSpan(
          text: '${widget.user['displayName']}',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
