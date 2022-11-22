import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class AddRequestMoneyContactViewModel extends BasePageViewModel {
  PublishSubject<bool> _addContactClickedSubject = PublishSubject();

  Stream<bool> get addContactClickedStream => _addContactClickedSubject.stream;

  void updateAddContactClickedValue(bool value) {
    _addContactClickedSubject.safeAdd(value);
  }
}
