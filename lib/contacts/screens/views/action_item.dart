import 'package:flutter/material.dart';

Widget actionItem(BuildContext context, {IconData? icon, String? text}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Row(
      children: <Widget>[
        // icons
        Container(
          height: 47,
          width: 47,
          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.redAccent,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 18,
          ),
        ),

        // action text item
        Text(
          '$text',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.black.withOpacity(.9),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    ),
  );
}
