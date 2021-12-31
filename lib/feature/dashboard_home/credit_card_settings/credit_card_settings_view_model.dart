import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class CreditCardSettingsViewModel extends BasePageViewModel {
  PublishSubject<bool> _toggleFreezeCardSubject = PublishSubject();

  Stream<bool> get freezeCardStream => _toggleFreezeCardSubject.stream;

  void toggleFreezeCardStatus(bool value) {
    _toggleFreezeCardSubject.safeAdd(value);
  }

  @override
  void dispose() {
    _toggleFreezeCardSubject.close();
    super.dispose();
  }
}
