import 'package:flutter_riverpod/all.dart';
import 'package:projectilelaundryapp/services/shared_preferences_service.dart';

final prefsProvider =
    Provider<SharedPreferencesService>((ref) => SharedPreferencesService());
