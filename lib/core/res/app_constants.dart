class AppConstant {
  // Settings
  static const String settingsBoxKey = 'settings';
  static const String booksBoxKey = 'books';
  static const String darkModeKey = 'darkMode';
  static const String followSystemThemeKey = 'followSystemTheme';
  static const String defaultStartingPageKey = 'defaultStartingPage';
  static const String lastUsedEnabledKey = 'lastUsedEnabled';
  static const String lastUsedIntKey = 'lastUsedInt';
  static const String leftNavigationRailKey = 'leftNavigationRail';
  static const String startingScreenButtonChoiceKey = 'startingScreenButtonChoice';

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

  // Appwrite
  // Mac
  // static const String url = 'http://129.107.97.163/';
  // static const String endpoint = 'http://129.107.97.163/v1';
  // static const String project = '60bbe0b4363f5';
  // Desktop
  static const String url = 'http://172.24.240.1';
  static const String endpoint = 'http://172.24.240.1/v1';
  static const String project = '611ffbae6bdd9';

  // Appwrite Database
  static const String readingStatsCollection = '61205e62f3bc5';
  static const String booksCollection = '61205e630fbcb';
  static const String shelvesCollection = '61205e636767b';

}

enum NavigationTabs{home, shelves, clubs, discover, more}
enum AppStates{loggedInAndOnline, loggedInAndOffline, notLoggedInAndOnline, notLoggedInAndOffline}
enum TileType{series, book}
enum BookFileType{epub, pdf, mobi, html}