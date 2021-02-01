import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:projectilelaundryapp/constants.dart';
import 'package:projectilelaundryapp/providers/user_data_provider.dart';
import 'package:projectilelaundryapp/services/firestore_service.dart';
import 'package:projectilelaundryapp/services/shared_preferences_service.dart';

final _firebaseAuth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;

class LoadDataPage extends StatefulWidget {
  @override
  _LoadDataPageState createState() => _LoadDataPageState();
}

class _LoadDataPageState extends State<LoadDataPage> {
  final prefs = SharedPreferencesService();

  final _db = FireStoreService(_firestore, _firebaseAuth.currentUser.uid);

  void loadData() async {
    final user = context.read(userDataProvider);
    await _db.getUserData().then(
      (value) async {
        user.assignUser(value);
        await prefs.saveToPrefs(value).then(
              (value) => Navigator.pushReplacementNamed(context, '/home'),
            );
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
    //final user = watch(userDataProvider);
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
