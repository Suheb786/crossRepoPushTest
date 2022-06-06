class LanguageEnum {
  final String _value;

  const LanguageEnum._(this._value);

  @override
  String toString() {
    return _value.toString();
  }

  static const LanguageEnum ENGLISH = LanguageEnum._('en');
  static const LanguageEnum ARABIC = LanguageEnum._('ar');
  static const LanguageEnum NONE = LanguageEnum._('none');
}

extension LanguageEnumExt on LanguageEnum {
  String fromLanguage() {
    switch (this) {
      case LanguageEnum.ENGLISH:
        return "English";
      case LanguageEnum.ARABIC:
        return "العربية";
      case LanguageEnum.NONE:
        return "";
      default:
        return "English";
    }
  }
}
