import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/bottom_sheet/date_picker_bottom_sheet/date_picker_bottom_sheet.dart';

class DatePicker {
  DatePicker._();

  static Future show(
    BuildContext context, {
    required Function(DateTime)? onSelected,
    required Function()? onCancelled,
    required String? title,
    required DateTime initialDate,
    DateTime? lastDate,
  }) async {
    return Platform.isAndroid
        ? showDatePicker(
                context: context,
                initialDate: initialDate,
                firstDate: DateTime(1900),
                lastDate: lastDate ?? DateTime(2100))
            .then((value) {
            value != null ? onSelected?.call(value) : () {};
          })
        : DatePickerBottomSheet.show(context, onDateSelected: (date) {
            onSelected?.call(date);
            Navigator.pop(context);
          }, onCancel: () {
            onCancelled?.call();
          }, title: title, initialDate: initialDate);
  }
}
