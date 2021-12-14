import 'package:domain/usecase/payment/send_amount_to_contact_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class SendAmountToContactViewModel extends BasePageViewModel {
  SendAmountToContactUseCase _useCase;

  PublishSubject<String> _purposeSubject = PublishSubject();

  Stream<String> get purposeStream => _purposeSubject.stream;

  PublishSubject<String> _purposeDetailSubject = PublishSubject();

  Stream<String> get purposeDetailStream => _purposeDetailSubject.stream;

  SendAmountToContactViewModel(this._useCase);

  void updatePurposeDetail(String value) {
    _purposeDetailSubject.safeAdd(value);
  }

  void updatePurpose(String value) {
    _purposeSubject.safeAdd(value);
  }

  @override
  void dispose() {
    _purposeDetailSubject.close();
    _purposeSubject.close();
    super.dispose();
  }
}
