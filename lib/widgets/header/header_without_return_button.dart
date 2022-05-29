import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HeaderWithoutBackButton extends StatelessWidget {
  final String titleScreen;
  final Widget? customAction;
  final PreferredSize? bottom;
  final bool? isCustom;
  const HeaderWithoutBackButton({
    required Key key,
    required this.titleScreen,
    this.bottom,
    this.isCustom: false,
    this.customAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[
              Color.fromRGBO(7, 91, 154, .9),
              Color.fromRGBO(20, 137, 253, .9),
            ],
          ),
        ),
      ),
      elevation: 1,
      // automaticallyImplyLeading: false,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
      title: Text(
        titleScreen,
        style: Theme.of(context).textTheme.headline6!.copyWith(
              color: Colors.white,
            ),
      ),
      bottom: bottom,
      actions: [
        isCustom! ? customAction! : _notification(),
      ],
    );
  }
}

Widget _notification() {
  return IconButton(
    tooltip: 'Notifications',
    icon: Icon(
      Icons.notifications_none,
      color: Colors.white,
    ),
    onPressed: () {
      // authentificationBloc(context).add(LogOut());
      Get.toNamed('/notification');
    },
  );
}
