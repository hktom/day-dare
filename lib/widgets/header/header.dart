import 'package:application_challenge/notification/screens/notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Header extends StatelessWidget {
  final String titleScreen;
  final bool? hidden;
  const Header({
    required Key key,
    required this.titleScreen,
    this.hidden: false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).accentColor,
      elevation: 2,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black.withOpacity(.8),
            ),
            onPressed: () => {Get.back()},
            tooltip: 'Retour',
          );
        },
      ),
      title: Text(
        titleScreen,
        style: Theme.of(context).textTheme.headline6,
      ),
      actions: [
        hidden!
            ? SizedBox()
            : IconButton(
                tooltip: 'Notifications',
                icon: Icon(
                  Icons.notifications_none,
                  color: Colors.black.withOpacity(.8),
                ),
                onPressed: () {
                  Get.to(Notifications());
                },
              ),
      ],
    );
  }
}
