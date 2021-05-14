import 'package:shodana_reader/data/local/starting_screen_source.dart';
import 'package:shodana_reader/data/repository/starting_screen_repository.dart';

class StartingScreenRepositoryImpl implements StartingScreenRepository {
  StartingScreenRepositoryImpl({required StartingScreenSource dataSource})
      : _dataSource = dataSource;

  final StartingScreenSource _dataSource;

  @override
  Future<BottomNavItems?> loadStartingScreen() {
    return _dataSource.loadStartingScreen();
  }

  @override
  Future<void> saveStartingScreen(BottomNavItems screen) {
    return _dataSource.saveStartingScreen(screen);
  }
}