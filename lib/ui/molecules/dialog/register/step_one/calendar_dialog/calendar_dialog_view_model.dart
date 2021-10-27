import 'package:neo_bank/base/base_page_view_model.dart';

class CalendarDialogViewModel extends BasePageViewModel {
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay = DateTime.now();

  int month = 1;
  int year = 1;
  int date = 1;

  void updateSelectedDate(DateTime selectedDate, DateTime focusedDate) {
    selectedDay = selectedDate;
    focusedDay = focusedDate;
    notifyListeners();
  }
}
