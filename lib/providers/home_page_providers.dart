import 'package:flutter_riverpod/all.dart';

final drawerStateProvider = StateProvider<bool>((ref) {
  return false;
});

final xOffsetProvider = StateProvider<double>((ref) {
  return 0;
});

final yOffsetProvider = StateProvider<double>((ref) {
  return 0;
});

final scaleProvider = StateProvider<double>((ref) {
  return 1;
});
