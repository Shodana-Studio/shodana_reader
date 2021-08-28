// ignore_for_file: do_not_use_environment

/// This class is only for server related data that should be kept hidden
class EnvironmentConfig {
  // We add the api key by running `flutter run --dart-define=apiKey=MYKEY`
  static const appwriteEndpoint = String.fromEnvironment('appwriteEndpoint');
  static const appwriteProjectId = String.fromEnvironment('appwriteProjectId');
  static const appwriteApiKey = String.fromEnvironment('appwriteApiKey');

}