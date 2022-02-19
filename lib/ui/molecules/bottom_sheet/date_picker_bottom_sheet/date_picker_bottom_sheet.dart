import 'package:flutter/cupertino.dart';
import 'package:neo_bank/ui/molecules/cupertino_bottom_sheet.dart';

import 'date_picker_bottom_sheet_view.dart';

class DatePickerBottomSheet {
  DatePickerBottomSheet._();

  static show(
    BuildContext context, {
    String? title,
    Function(DateTime)? onDateSelected,
    Function()? onCancel,
    required DateTime initialDate,
  }) async {
    CupertinoBottomSheet.show(context, builder: (context) {
      return DatePickerBottomSheetView(
          onDateSelected: (_) => onDateSelected?.call(_),
          title: title,
          initialDate: initialDate,
          onCancel: () => onCancel?.call());
    });
  }
}
