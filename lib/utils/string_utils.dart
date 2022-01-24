class StringUtils {
  StringUtils._();

  /// first initials
  static String getFirstInitials(String? name) {
    String fullName = name!;
    List<String> separatedName = fullName.split(" ");
    print(separatedName[0]);
    print(separatedName[1]);
    String initials =
        separatedName[0][0].toUpperCase() + separatedName[1][0].toUpperCase();
    return initials;
  }

  ///get formatted credit card
  static String getFormattedCreditCardNumber(String? cardNo) {
    var buffer = new StringBuffer();
    for (int i = 0; i < cardNo!.length; i++) {
      buffer.write(cardNo[i]);
      var index = i + 1;
      if (index % 4 == 0 && index != cardNo.length) {
        buffer.write(' ');
      }
    }
    return buffer.toString();
  }

  ///get last 3 digit of cvv
  static String getCvv(String? cvv) {
    String currentCvv = cvv!;
    if (currentCvv.length > 3) {
      return currentCvv.substring(cvv.length - 3);
    } else {
      return currentCvv;
    }
  }
}
