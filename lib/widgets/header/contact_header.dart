import 'package:application_challenge/challenge/bloc/challenge_bloc.dart';
import 'package:application_challenge/contacts/bloc/contact_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

import '../../bloc.dart';

// ignore: must_be_immutable
class ContactHeader extends StatefulWidget {
  final String titleScreen;
  List? contactList;
  ContactHeader({
    Key? key,
    required this.titleScreen,
    this.contactList,
  }) : super(key: key);

  @override
  _ContactHeaderState createState() => _ContactHeaderState();
}

class _ContactHeaderState extends State<ContactHeader> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 2,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black.withOpacity(.8),
            ),
            onPressed: () {
              challengeBloc(context).add(RefreshInvitationList());
              Get.offAllNamed("/home");
            },
            tooltip: 'Retour',
          );
        },
      ),
      title: Text(
        widget.contactList!.length < 1
            ? "${widget.titleScreen}"
            : "${widget.contactList!.length} invitation(s)",
        style: Theme.of(context).textTheme.headline6,
      ),
      actions: [
        IconButton(
          tooltip: 'Recherche',
          icon: Icon(
            EvaIcons.searchOutline,
            color: Colors.black.withOpacity(.8),
          ),
          onPressed: () => {
            // BlocProvider.of<ContactBloc>(context).add(OnSearchStarting()),
          },
        ),
      ],
    );
  }
}
