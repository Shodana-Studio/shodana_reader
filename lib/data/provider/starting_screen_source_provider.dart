import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../local/starting_screen_source_impl.dart';
import 'app_shared_preferences_provider.dart';

final startingScreenSourceProvider =
Provider((ref) => StartingScreenSourceImpl(ref.read(prefsProvider)));