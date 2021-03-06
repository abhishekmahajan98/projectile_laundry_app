import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:projectilelaundryapp/constants.dart';
import 'package:projectilelaundryapp/providers/authentication_providers.dart';

final loginEmailProvider = StateProvider<String>((ref) {
  return null;
});
final loginPasswordProvider = StateProvider<String>((ref) {
  return null;
});

class Login extends ConsumerWidget {
  void updateEmail(BuildContext context, String email) {
    context.read(loginEmailProvider).state = email;
  }

  void updatePassword(BuildContext context, String pass) {
    context.read(loginPasswordProvider).state = pass;
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    //TextEditingController _controller;
    String email = watch(loginEmailProvider).state;
    String password = watch(loginPasswordProvider).state;
    final _auth = watch(authenticationServiceProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Welcome to",
          style: TextStyle(
            fontSize: 16,
            color: blurredMainColor,
            height: 2,
          ),
        ),
        Text(
          "GIMME LAUNDRY",
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: blurredMainColor,
            letterSpacing: 2,
            height: 1,
          ),
        ),
        Text(
          "Please login to continue",
          style: TextStyle(
            fontSize: 16,
            color: blurredMainColor,
            height: 1,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        TextField(
          onChanged: (value) => updateEmail(context, value),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'Email',
            hintStyle: TextStyle(
              fontSize: 16,
              color: Colors.black,
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
            fillColor: blurredMainColor,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        TextField(
          //controller: _controller,
          onChanged: (value) => updatePassword(context, value),
          keyboardType: TextInputType.text,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Password',
            hintStyle: TextStyle(
              fontSize: 16,
              color: Colors.black,
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
            fillColor: blurredMainColor,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          ),
        ),
        SizedBox(
          height: 24,
        ),
        GestureDetector(
          onTap: () {
            print(email + ' ' + password);
            _auth.emailLogin(email: email, password: password).then(
              (value) {
                updateEmail(context, null);
                updatePassword(context, null);
                Navigator.pushReplacementNamed(context, '/buffer_page');
              },
            );
          },
          /*onTap: () async {
            await _auth.emailLogin(email: email, password: password).then(
                  (value) => Navigator.pushNamed(context, '/buffer_page'),
                );
          },*/
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 4,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Text(
                "LOGIN",
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
          height: 16,
        ),
        Text(
          "FORGOT PASSWORD?",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: blurredMainColor,
            height: 1,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Or Login with",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: blurredMainColor,
                height: 1,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Entypo.google__with_circle,
              size: 50,
              color: blurredMainColor,
            ),
          ],
        ),
      ],
    );
  }
}
