class StringConverter {
  StringConverter._();

  /// get middle name
  static String getMiddleName(String? name) {
    try {
      if (name!.isEmpty) {
        return name;
      }
      List<String> _flName = name.split(" ");
      if (_flName.isEmpty) {
        return name;
      }
      if (_flName.length > 1) {
        return _flName[1];
      }
      return _flName.first;
    } catch (exception) {
      return name![0];
    }
  }

  /// get full name
  static String getFullName({String? primaryId, String? secondaryId, String? fullName}) {
    try {
      if (primaryId!.isEmpty || secondaryId!.isEmpty) {
        return fullName ?? '';
      }
      String fullUserName = '';
      fullUserName = secondaryId + ' ' + primaryId;

      return fullUserName;
    } catch (exception) {
      return fullName ?? '';
    }
  }
}
