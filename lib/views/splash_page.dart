import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:projectilelaundryapp/constants.dart';
import 'package:projectilelaundryapp/providers/authentication_providers.dart';
import 'package:projectilelaundryapp/views/home_page.dart';
import 'package:projectilelaundryapp/views/login_page.dart';

class SplashPage extends ConsumerWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    //final authState = watch(authStateChangesProvider);
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Something Went wrong"),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return AuthCheckWidget();
        }
        return Scaffold(
          backgroundColor: mainColor,
          body: Center(
            child: Text(
              'Gimme',
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      },
    );
  }
}

class AuthCheckWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final authState = watch(authStateChangesProvider);
    return authState.when(
      data: (user) {
        if (user != null) {
          return HomePage();
        }
        return LoginPage();
      },
      loading: () {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      error: (_, __) {
        return Scaffold(
          body: Center(
            child: Text('OOPS'),
          ),
        );
      },
    );
  }
}
