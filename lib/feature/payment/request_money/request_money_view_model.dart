import 'package:domain/usecase/payment/request_money_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class RequestMoneyViewModel extends BasePageViewModel {
  RequestMoneyUseCase _useCase;

  PublishSubject<Resource<bool>> _getValueResponse = PublishSubject();

  Stream<Resource<bool>> get getValueResponseStream => _getValueResponse.stream;

  PublishSubject<RequestMoneyUseCaseParams> _moneyRequest = PublishSubject();

  RequestMoneyViewModel(this._useCase) {
    _moneyRequest.listen((value) {
      RequestManager(value, createCall: () => _useCase.execute(params: value)).asFlow().listen((event) {
        updateLoader();
        _getValueResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });
  }

  void requestMoney() {
    print("current pin value: $currentPinValue");
    _moneyRequest.safeAdd(RequestMoneyUseCaseParams(amount: currentPinValue));
  }

  List<String> myList = [];
  String currentPinValue = '0';

  void changeValue(String value) {
    if (value == ".") {
      if (!currentPinValue.contains(value)) {
        myList.add(value);
        currentPinValue = myList.join("");
      }
    } else {
      if (myList.contains(".")) {
        if (myList.indexOf(".") > myList.length - 4) {
          myList.add(value);
        }
      } else {
        myList.add(value);
      }
      currentPinValue = myList.join("");
    }
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
      myList.removeAt(myList.length - 1);
      if (myList.isEmpty) {
        currentPinValue = "0";
      } else {
        currentPinValue = myList.join();
      }
    } else if (myList.isEmpty) {
      currentPinValue = "0";
    }
    print("got myList : $myList");
    notifyListeners();
  }
}
