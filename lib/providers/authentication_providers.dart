import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:projectilelaundryapp/services/authentication_service.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);
final authenticationServiceProvider = Provider<AuthenticationService>((ref) {
  return AuthenticationService(ref.read(firebaseAuthProvider));
});

final authStateChangesProvider = StreamProvider<User>(
    (ref) => ref.watch(firebaseAuthProvider).authStateChanges());
