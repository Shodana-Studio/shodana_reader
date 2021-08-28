class EnvironmentConfig {
  // We add the api key by running `flutter run --dart-define=apiKey=MYKEY`
  final APPWRITE_ENDPOINT = const String.fromEnvironment('APPWRITE_ENDPOINT');
  final APPWRITE_FUNCTION_PROJECT_ID = const String.fromEnvironment('APPWRITE_FUNCTION_PROJECT_ID');
  final APPWRITE_API_KEY = const String.fromEnvironment('APPWRITE_API_KEY');
}