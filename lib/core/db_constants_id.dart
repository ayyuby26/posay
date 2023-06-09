class DbConstantsId {
  static DbConstantsId? _instance;

  factory DbConstantsId() {
    _instance ??= DbConstantsId._();
    return _instance!;
  }

  DbConstantsId._();

  static String get databaseId => "647cf24da7aa1549c941";
  static String get authId => "647cf43a799b57f5e20c";
  static String get stockId => "6480bd15643cad33520d";
}
