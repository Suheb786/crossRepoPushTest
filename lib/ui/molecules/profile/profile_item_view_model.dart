import 'package:neo_bank/base/base_view_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';

class ProfileItemViewModel extends BaseViewModel {
  final PublishSubject<bool> _switchSubject = PublishSubject();

  Stream<bool> get switchState => _switchSubject.stream;

  void updateState(bool value) {
    _switchSubject.safeAdd(value);
  }

  @override
  void dispose() {
    _switchSubject.close();
    super.dispose();
  }
}
