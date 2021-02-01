import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:projectilelaundryapp/providers/user_data_provider.dart';
import 'package:projectilelaundryapp/services/authentication_service.dart';
import 'package:projectilelaundryapp/services/shared_preferences_service.dart';

import '../constants.dart';

final _firebaseAuth = FirebaseAuth.instance;

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final prefs = SharedPreferencesService();

  final _auth = AuthenticationService(_firebaseAuth);

  void loadData() async {
    final user = context.read(userDataProvider);
    prefs.checkPrefs().then(
      (prefData) async {
        if (prefData == true && _auth.loggedInUser != null) {
          await prefs.loadFromPrefs().then(
            (userData) {
              user.assignUser(userData);
              Navigator.pushReplacementNamed(context, '/home');
            },
          );
        }
        if (_auth.loggedInUser == null) {
          await prefs.clearPrefs();
          Navigator.pushReplacementNamed(context, '/login');
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
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
  }
}
