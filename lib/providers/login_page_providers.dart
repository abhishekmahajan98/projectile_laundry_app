import 'package:flutter_riverpod/all.dart';

final loginPageStateProvider = StateProvider<bool>((ref) {
  return true;
});

final loginEmailState = StateProvider<String>((ref) {
  return null;
});
final signupEmailState = StateProvider<String>((ref) {
  return null;
});
final loginPasswordState = StateProvider<String>((ref) {
  return null;
});
final signupPasswordState = StateProvider<String>((ref) {
  return null;
});
