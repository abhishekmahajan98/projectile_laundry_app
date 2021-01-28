import 'package:flutter/material.dart';

import '../constants.dart';

Widget drawerItem({String title, IconData data, Function onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Row(
      children: [
        Icon(
          data,
          size: 30,
          color: mainColor,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: TextStyle(
            color: mainColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        )
      ],
    ),
  );
}
