import 'package:flutter/cupertino.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

class DatePickerBottomSheetView extends StatefulWidget {
  final Function(DateTime)? onDateSelected;
  final Function()? onCancel;
  final String? title;
  final DateTime initialDate;
  final DateTime? firstDate;

  const DatePickerBottomSheetView(
      {this.onDateSelected, this.title, this.onCancel, required this.initialDate, this.firstDate});

  @override
  _DatePickerBottomSheetViewState createState() => _DatePickerBottomSheetViewState();
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
            fontSize: 13.t,
            color: AppColor.dark_grayish_blue),
      ),
      message: Text(S.of(context).scrollToSetDate(widget.title!.toLowerCase()),
          style: TextStyle(
              fontFamily: 'SF Pro Text',
              fontWeight: FontWeight.w400,
              fontSize: 13.t,
              color: AppColor.dark_grayish_blue)),
      actions: [
        Container(
          height: MediaQuery.of(context).copyWith().size.height / 3.5,
          child: CupertinoDatePicker(
            initialDateTime: widget.initialDate,
            // minimumDate: widget.firstDate ?? DateTime(1900),
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (DateTime newdate) {
              selectedDateTime = newdate;
            },
          ),
        ),
        CupertinoActionSheetAction(
          child: Text(S.of(context).confirm,
              style: TextStyle(fontFamily: 'SF Pro Text', fontSize: 17.t, color: AppColor.pure_blue)),
          onPressed: () {
            widget.onDateSelected?.call(selectedDateTime);
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text(S.of(context).cancel,
            style: TextStyle(
                fontFamily: 'SF Pro Text',
                fontWeight: FontWeight.w600,
                fontSize: 17.t,
                color: AppColor.pure_blue)),
        onPressed: () {
          widget.onCancel?.call();
        },
      ),
    );
  }
}
