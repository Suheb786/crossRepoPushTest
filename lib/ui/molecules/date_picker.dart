import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/bottom_sheet/date_picker_bottom_sheet/date_picker_bottom_sheet.dart';

class DatePicker {
  DatePicker._();

  static Future show(
    BuildContext context, {
    required Function(String)? onSelected,
    required Function()? onCancelled,
    required String? title,
  }) async {
    DateTime selectedDate = DateTime.now();
    return Platform.isAndroid
        ? showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
          ).then((value) {
            onSelected?.call(value.toString());
          })
        : DatePickerBottomSheet.show(context, onDateSelected: (date) {
            Navigator.pop(context);
            onSelected?.call(date);
          }, onCancel: () {
            onCancelled?.call();
          }, title: title);
  }
}
