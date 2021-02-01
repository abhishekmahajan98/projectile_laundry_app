import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();
  String get userId => _firebaseAuth.currentUser.uid;
  User get loggedInUser => _firebaseAuth.currentUser;

  Future<int> emailLogin({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 1;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return 0;
    }
  }

  Future<int> emailSignUp({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 1;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return 0;
    }
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
