class AppConstant {
  // Settings
  static const String settingsBoxKey = 'settings';
  static const String booksBoxKey = 'bookBox';

  static const String darkModeKey = 'darkMode';
  static const String followSystemThemeKey = 'followSystemTheme';
  static const String defaultStartingPageKey = 'defaultStartingPage';
  static const String lastUsedEnabledKey = 'lastUsedEnabled';
  static const String lastUsedIntKey = 'lastUsedInt';
  static const String leftNavigationRailKey = 'leftNavigationRail';
  static const String startingScreenButtonChoiceKey =
      'startingScreenButtonChoice';

  // Starting screen choices
  static const String startingScreenKey = 'startingScreen';
  static const String lastUsedScreen = 'last_used';
  static const String homeScreen = 'home';
  static const String shelvesScreen = 'shelves';
  static const String clubsScreen = 'clubs';
  static const String discoverScreen = 'discover';
  static const String moreScreen = 'more';

  // Intro
  static const String welcomeShown = 'welcome_shown';

  // Appwrite Over Internet
  static const String url = 'http://70.117.147.11/';
  static const String endpoint = 'http://70.117.147.11/v1';
  static const String project = '615a678115f4d';

  // Appwrite Local
  // static const String url = 'http://192.168.1.203/';
  // static const String endpoint = 'http://192.168.1.203/v1';
  // static const String project = '615a678115f4d';

  // Appwrite Database
  static const String readingStatsCollection = '6164bc1b24fc4';
  static const String booksCollection = '6164bc1b4f455';
  static const String shelvesCollection = '6164bc1bc7ea5';
}

enum AppPage { home, shelves, clubs, discover }
enum AppStates {
  loggedInAndOnline,
  loggedInAndOffline,
  notLoggedInAndOnline,
  notLoggedInAndOffline
}
enum TileType { series, book }
enum BookFileType { epub, pdf, mobi, html }
