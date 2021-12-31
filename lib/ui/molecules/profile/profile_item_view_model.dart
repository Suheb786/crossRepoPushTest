import 'package:neo_bank/base/base_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class ProfileItemViewModel extends BaseViewModel {
  final PublishSubject<bool> _switchState = PublishSubject();

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
