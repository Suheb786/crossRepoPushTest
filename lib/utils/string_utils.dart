import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class StringUtils {
  StringUtils._();

  /// first initials
  static String getFirstInitials(String? name) {
    try {
      if (name!.isEmpty) {
        debugPrint('Name is empty--->>$name');
        return name;
      }
      List<String> _flName = name.split(" ");
      if (_flName.isEmpty) {
        debugPrint('_flName is empty--->>$name');
        return name;
      }
      if (_flName.length > 1) {
        debugPrint('_flName is greater than 1--->>${_flName.first[0] + _flName.last[0]}');
        return _flName.first[0] + _flName.last[0];
      }
      return _flName.first[0];
    } catch (exception) {
      debugPrint('Inside exception---${exception}');
      return name![0];
    }
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

  ///get last 4 digit of cardNumber
  static String getLastFourDigitOfCardNo(String? cardNumber) {
    String currentNo = cardNumber!;
    if (currentNo.length > 4) {
      return currentNo.substring(currentNo.length - 4);
    } else {
      return currentNo;
    }
  }

  ///get min due date
  static String getMinDueDate() {
    DateTime currentDate = DateTime.now();

    String month = currentDate.month < 10 ? '0${currentDate.month}' : currentDate.month.toString();
    String minDueDate = '28/${month}';
    return minDueDate;
  }

  static bool isDirectionRTL(BuildContext context) {
    return intl.Bidi.isRtlLanguage(Localizations.localeOf(context).languageCode);
  }

  static String appFont = intl.Intl.getCurrentLocale() == 'en' ? "Montserrat" : 'Tajawal';
}
