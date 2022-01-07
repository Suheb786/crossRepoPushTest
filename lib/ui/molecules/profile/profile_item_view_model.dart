import 'package:neo_bank/base/base_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class ProfileItemViewModel extends BaseViewModel {
  final BehaviorSubject<bool> _switchState = BehaviorSubject();

  Stream<bool> get switchState => _switchState.stream;

  void updateState(bool value) {
    _switchState.safeAdd(value);
  }

  @override
  void dispose() {
    //_switchState.close();
    super.dispose();
  }
}
