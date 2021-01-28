import 'package:flutter/material.dart';

import '../constants.dart';

class SignUpOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "OR",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            height: 1,
            color: mainColor,
          ),
        ),
        SizedBox(
          height: 24,
        ),
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
            boxShadow: [
              BoxShadow(
                color: mainColor.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 4,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              "SIGN UP",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: blurredMainColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
