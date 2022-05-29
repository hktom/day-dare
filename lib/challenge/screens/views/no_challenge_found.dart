// import 'package:application_challenge/challenge/screens/views/mobile_gallery.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget noChallengeFound(BuildContext context,
    {required String? infos, IconData? icon, Color? iconColor}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        height: 170,
        width: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.blueGrey.withOpacity(.1),
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: 40,
        ),
      ),
      Center(
          child: Container(
        padding: const EdgeInsets.all(30),
        child: Text(
          '$infos',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.blueGrey,
              ),
          textAlign: TextAlign.center,
        ),
      )),
      Center(
        child: InkWell(
          onTap: () {
            Get.toNamed('/create_challenge');
          },
          child: Text(
            "Nouveau Challenge",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.blue,
                ),
          ),
        ),
      ),
    ],
  );
}
