import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../local/starting_screen_source.dart';
import '../repository/starting_screen_repository.dart';
import '../repository/starting_screen_repository_impl.dart';
import 'starting_screen_source_provider.dart';

// final appThemeStateNotifier = StateNotifierProvider.autoDispose<AppThemeState, BottomNavItems>((ref) {
//   return AppThemeState();
// });

final startingScreenRepositoryProvider = Provider<StartingScreenRepository>((ref) =>
    StartingScreenRepositoryImpl(dataSource: ref.read(startingScreenSourceProvider)));



class AppThemeState extends StateNotifier<BottomNavItems> {
  AppThemeState(): super(BottomNavItems.home);

  void setHome() => state = BottomNavItems.home;
  void setShelves() => state = BottomNavItems.shelves;
  void setClubs() => state = BottomNavItems.shelves;
  void setDiscover() => state = BottomNavItems.shelves;
  void setMore() => state = BottomNavItems.shelves;
}