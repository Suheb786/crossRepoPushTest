class AppLocalException implements Exception {
  final AppLocalExceptionType appLocalExceptionType;

  AppLocalException({required this.appLocalExceptionType});
}

class AppLocalExceptionType {
  final int _value;

  const AppLocalExceptionType._(this._value);

  int get value => this._value;

  static const AppLocalExceptionType NO_USER_FOUND = AppLocalExceptionType._(2);
  static const AppLocalExceptionType NO_DATA_FOUND = AppLocalExceptionType._(3);
}
