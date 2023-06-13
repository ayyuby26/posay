class AppwriteConfig {
  String get projectId => const String.fromEnvironment('PROJECT_ID');
  String get apiEndPoint => const String.fromEnvironment('API_END_POINT');
  String get apiKeyScreet => const String.fromEnvironment('API_KEY_SCREET');
}
