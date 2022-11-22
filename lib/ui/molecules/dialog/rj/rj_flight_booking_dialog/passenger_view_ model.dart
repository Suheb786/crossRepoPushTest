import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/rj/rj_flight_booking_dialog/rj_flight_booking_dialog_view_model.dart';
import 'package:rxdart/rxdart.dart';

class PassengerViewModel extends BasePageViewModel {
  PublishSubject<int> _incrementDecrementSubject = PublishSubject();

  Stream<int> get incrementDecrementSubjectStream => _incrementDecrementSubject.stream;

  List<Passenger> passengerList = [];

  void incrementCounter(int count, int index) {
    if (count >= 0) {
      _incrementDecrementSubject.add(count);
      passengerList[index].count = count;
    }
  }

  void decrementCounter(int count, int index) {
    if (count >= 0) {
      _incrementDecrementSubject.add(count);
      passengerList[index].count = count;
    }
  }

  @override
  void dispose() {
    _incrementDecrementSubject.close();
    super.dispose();
  }
}
