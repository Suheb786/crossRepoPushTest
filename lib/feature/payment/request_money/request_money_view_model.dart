import 'package:domain/usecase/payment/request_money_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';

class RequestMoneyViewModel extends BasePageViewModel {
  RequestMoneyUseCase _useCase;

  RequestMoneyViewModel(this._useCase);

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
}
