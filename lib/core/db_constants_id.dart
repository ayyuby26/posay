class DbConstantsId {
  static DbConstantsId? _instance;

  factory DbConstantsId() {
    _instance ??= DbConstantsId._();
    return _instance!;
  }

  DbConstantsId._();

  static String get databaseId => const String.fromEnvironment('DATABASE_ID');
  static String get authId => const String.fromEnvironment('AUTH_ID');
  static String get stockId => const String.fromEnvironment('STOCK_ID');
}
