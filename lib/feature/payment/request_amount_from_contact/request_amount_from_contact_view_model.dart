import 'package:domain/usecase/payment/request_amount_from_contact_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class RequestAmountFromContactViewModel extends BasePageViewModel {
  RequestAmountFromContactUseCase _useCase;

  PublishSubject<String> _purposeSubject = PublishSubject();

  Stream<String> get purposeStream => _purposeSubject.stream;

  PublishSubject<String> _purposeDetailSubject = PublishSubject();

  Stream<String> get purposeDetailStream => _purposeDetailSubject.stream;

  void updatePurposeDetail(String value) {
    _purposeDetailSubject.safeAdd(value);
  }

  void updatePurpose(String value) {
    _purposeSubject.safeAdd(value);
  }

  RequestAmountFromContactViewModel(this._useCase);

  List<String> myList = [];
  String currentPinValue = '0';

  void changeValue(String value) {
    myList.add(value);
    currentPinValue = myList.join("");
    notifyListeners();
  }

  void updateValue() {
    currentPinValue = currentPinValue.substring(0, currentPinValue.length - 1);
    myList.clear();
    if (currentPinValue.length < 1) {
      currentPinValue = '0';
    }
    notifyListeners();
  }

  void clearValue() {
    if (myList.isNotEmpty) {
      myList.clear();
      currentPinValue = "0";
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _purposeSubject.close();
    _purposeDetailSubject.close();
    super.dispose();
  }
}
