import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:projectilelaundryapp/providers/login_page_providers.dart';

import '../constants.dart';

class SignUp extends ConsumerWidget {
  void updateSignupEmailState(BuildContext context, String email) {
    context.read(signupEmailState).state = email;
  }

  void updateSignupPasswordState(BuildContext context, String pass) {
    context.read(signupPasswordState).state = pass;
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    String email = watch(signupEmailState).state;
    String password = watch(signupPasswordState).state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Sign up with",
          style: TextStyle(
            fontSize: 16,
            color: mainColor,
            height: 2,
          ),
        ),
        Text(
          "GIMME LAUNDRY",
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: mainColor,
            letterSpacing: 2,
            height: 1,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        TextField(
          onChanged: (value) => updateSignupEmailState(context, value),
          decoration: InputDecoration(
            hintText: 'Enter Email',
            hintStyle: TextStyle(
              fontSize: 16,
              color: mainColor,
              fontWeight: FontWeight.bold,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            fillColor: Colors.grey.withOpacity(0.1),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        TextField(
          onChanged: (value) => updateSignupPasswordState(context, value),
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Password',
            hintStyle: TextStyle(
              fontSize: 16,
              color: mainColor,
              fontWeight: FontWeight.bold,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            fillColor: Colors.grey.withOpacity(0.1),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          ),
        ),
        SizedBox(
          height: 24,
        ),
        GestureDetector(
          onTap: () {
            print(email);
            print(password);
          },
          child: Container(
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
        ),
        SizedBox(
          height: 24,
        ),
        Text(
          "Or Signup with",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: mainColor,
            height: 1,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Entypo.facebook_with_circle,
              size: 32,
              color: mainColor,
            ),
            SizedBox(
              width: 24,
            ),
            Icon(
              Entypo.google__with_circle,
              size: 32,
              color: mainColor,
            ),
          ],
        )
      ],
    );
  }
}
