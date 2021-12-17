class StringUtils {
  StringUtils._();

  /// first initials
  static String getFirstInitials(String? name) {
    String fullName = name!;
    List<String> separatedName = fullName.split(" ");
    String initials =
        separatedName[0][0].toUpperCase() + separatedName[1][0].toUpperCase();
    return initials;
  }
}
