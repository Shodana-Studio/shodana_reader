import '../local/starting_screen_source.dart';

abstract class StartingScreenRepository {
  Future<BottomNavItems?> loadStartingScreen();

  Future<void> saveStartingScreen(BottomNavItems screen);
}