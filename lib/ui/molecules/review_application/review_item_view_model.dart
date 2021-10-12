import 'package:neo_bank/base/base_view_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';

class ReviewItemViewModel extends BaseViewModel {
  final PublishSubject<bool> _checkBoxSubject = PublishSubject();

  Stream<bool> get checkBoxState => _checkBoxSubject.stream;

  void updateState(bool value) {
    _checkBoxSubject.safeAdd(value);
  }

  @override
  void dispose() {
    _checkBoxSubject.close();
    super.dispose();
  }
}
