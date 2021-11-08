import 'package:flutter/cupertino.dart';
import 'package:neo_bank/ui/molecules/cupertino_bottom_sheet.dart';

import 'date_picker_bottom_sheet_view.dart';

class DatePickerBottomSheet {
  DatePickerBottomSheet._();

  static show(
    BuildContext context, {
    Function(String)? onDateSelected,
  }) async {
    CupertinoBottomSheet.show(context, builder: (context) {
      return DatePickerBottomSheetView(
        onDateSelected: onDateSelected,
      );
    });
  }
}
