import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:projectilelaundryapp/models/active_user_model.dart';

class UserDataProviderClass extends ChangeNotifier {
  ActiveUserModel _activeUser;

  ActiveUserModel get activeUser => _activeUser;

  void assignUser(ActiveUserModel user) {
    _activeUser = user;
    notifyListeners();
  }
}

final userDataProvider = ChangeNotifierProvider<UserDataProviderClass>(
  (ref) => UserDataProviderClass(),
);
