import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/color_utils.dart';

class DatePickerBottomSheetView extends StatefulWidget {
  final Function(String)? onDateSelected;
  final Function()? onCancel;
  final String? title;

  const DatePickerBottomSheetView(
      {this.onDateSelected, this.title, this.onCancel});

  @override
  _DatePickerBottomSheetViewState createState() =>
      _DatePickerBottomSheetViewState();
}

class _DatePickerBottomSheetViewState extends State<DatePickerBottomSheetView> {
  DateTime selectedDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Text(
        widget.title!,
        style: TextStyle(
            fontFamily: 'SF Pro Text',
            fontWeight: FontWeight.w700,
            fontSize: 13,
            color: AppColor.dark_grayish_blue),
      ),
      message: Text(S.of(context).scrollToSetDate(widget.title!.toLowerCase()),
          style: TextStyle(
              fontFamily: 'SF Pro Text',
              fontWeight: FontWeight.w400,
              fontSize: 13,
              color: AppColor.dark_grayish_blue)),
      actions: [
        Container(
          height: MediaQuery.of(context).copyWith().size.height / 3.5,
          child: CupertinoDatePicker(
            initialDateTime: DateTime.now(),
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (DateTime newdate) {
              selectedDateTime = newdate;
            },
          ),
        ),
        CupertinoActionSheetAction(
          child: Text(S.of(context).confirm,
              style: TextStyle(
                  fontFamily: 'SF Pro Text',
                  fontSize: 17,
                  color: AppColor.pure_blue)),
          onPressed: () {
            widget.onDateSelected?.call(selectedDateTime.toString());
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text(S.of(context).cancel,
            style: TextStyle(
                fontFamily: 'SF Pro Text',
                fontWeight: FontWeight.w600,
                fontSize: 17,
                color: AppColor.pure_blue)),
        onPressed: () {
          widget.onCancel?.call();
        },
      ),
    );
  }
}
