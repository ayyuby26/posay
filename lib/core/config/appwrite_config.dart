class AppwriteConfig {
  String get projectId => const String.fromEnvironment('PROJECT_ID');
  String get apiEndPoint => "https://cloud.appwrite.io/v1";
  String get apiKeyScreet => const String.fromEnvironment('API_KEY_SCREET');
}
