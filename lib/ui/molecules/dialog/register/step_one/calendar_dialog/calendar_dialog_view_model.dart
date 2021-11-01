import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class CalendarDialogViewModel extends BasePageViewModel {
  int month = 1;
  int year = 1;
  int date = 1;

  ///date params subject holder
  PublishSubject<DateParameters> _dateParamsSubject = PublishSubject();

  ///date params stream
  Stream<DateParameters> get dateParamsStream => _dateParamsSubject.stream;

  void updateSelectedDate(DateTime selectedDate, DateTime focusedDate) {
    _dateParamsSubject.safeAdd(
        DateParameters(focusedDay: focusedDate, selectedDay: selectedDate));
  }

  @override
  void dispose() {
    _dateParamsSubject.close();
    super.dispose();
  }
}

class DateParameters {
  final DateTime? focusedDay;
  final DateTime? selectedDay;

  DateParameters({this.focusedDay, this.selectedDay});
}
