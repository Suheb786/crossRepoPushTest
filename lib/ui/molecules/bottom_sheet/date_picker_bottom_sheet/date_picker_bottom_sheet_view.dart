import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatePickerBottomSheetView extends StatefulWidget {
  final Function(String)? onDateSelected;

  const DatePickerBottomSheetView({this.onDateSelected});

  @override
  _DatePickerBottomSheetViewState createState() =>
      _DatePickerBottomSheetViewState();
}

class _DatePickerBottomSheetViewState extends State<DatePickerBottomSheetView> {
  DateTime selectedDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Text('Date of Birth'),
      message: Text('Scroll to set your date of birth'),
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
          child: Text("Confirm"),
          onPressed: () {
            widget.onDateSelected?.call(selectedDateTime.toString());
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text("Cancel"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
