import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class CliqInformationDialogViewModel extends BasePageViewModel {
  BehaviorSubject<bool> _selectedSubject = BehaviorSubject();

  Stream<bool> get selectedStream => _selectedSubject.stream;

  void isSelected(bool value) {
    _selectedSubject.safeAdd(value);
  }
}
