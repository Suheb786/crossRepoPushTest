import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:rxdart/rxdart.dart';

class PassengerViewModel extends BasePageViewModel {
  PublishSubject<int> _incrementDecrementSubject = PublishSubject();

  Stream<int> get incrementDecrementSubjectStream => _incrementDecrementSubject.stream;

  void incrementCounter(int count) {
    print('incrementCounter $count');
    if (count >= 0) {
      _incrementDecrementSubject.add(count);
    }
  }

  void decrementCounter(int count) {
    if (count >= 0) {
      _incrementDecrementSubject.add(count);
    }
  }

  @override
  void dispose() {
    _incrementDecrementSubject.close();
    super.dispose();
  }
}
