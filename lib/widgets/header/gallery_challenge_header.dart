import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class GalleryChallengeHeader extends StatelessWidget {
  final String titleScreen;
  const GalleryChallengeHeader({
    Key? key,
    required this.titleScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 2,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
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
    );
  }
}

