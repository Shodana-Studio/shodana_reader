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
  // static const String url = 'http://localhost/';
  // static const String endpoint = 'http://localhost/v1';
  // static const String project = '60bbe0b4363f5';
  // Desktop
  static const String url = 'http://192.168.1.191';
  static const String endpoint = 'http://192.168.1.191/v1';
  static const String project = '611ffbae6bdd9';

  // Appwrite Database
  static const String readingStatsCollection = '613435387a69b';
  static const String booksCollection = '6134353890dd5';
  static const String shelvesCollection = '61343538cfeba';

}

enum NavigationTabs{home, shelves, clubs, discover, more}
enum AppStates{loggedInAndOnline, loggedInAndOffline, notLoggedInAndOnline, notLoggedInAndOffline}
enum TileType{series, book}
enum BookFileType{epub, pdf, mobi, html}