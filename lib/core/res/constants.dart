class AppConstant {
  // Settings
  static const String settingsBoxKey = 'settings';
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
  static const String url = 'http://192.168.1.47';
  static const String endpoint = 'http://192.168.1.47/v1';
  static const String project = '60bc0f558cab4';

}

enum NavigationTabs{home, shelves, clubs, discover, more}
enum TileType{series, book}
enum BookFileType{epub, pdf, mobi, html}