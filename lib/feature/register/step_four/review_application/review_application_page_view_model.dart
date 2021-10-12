import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:rxdart/rxdart.dart';

class ReviewApplicationPageViewModel extends BasePageViewModel {
  BehaviorSubject<bool> _errorDetectorSubject = BehaviorSubject.seeded(false);

  Stream<bool> get errorDetectorStream => _errorDetectorSubject.stream;
}
