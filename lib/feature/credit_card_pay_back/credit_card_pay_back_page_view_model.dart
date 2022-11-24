import 'package:domain/usecase/payment/pay_back_credit_card_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/credit_card_pay_back/credit_card_pay_back_page.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class CreditCardPayBackPageModel extends BasePageViewModel {
  final PayBackCreditCardUseCase _payBackCreditCardUseCase;
  final CreditCardPayBackArguments payBackArguments;
  List<String> myList = [];

  String currentPinValue = '0';

  ///pay back credit card handlers
  PublishSubject<PayBackCreditCardUseCaseParams> _payBackCreditCardRequest = PublishSubject();

  PublishSubject<Resource<bool>> _payBackCreditCardResponse = PublishSubject();

  Stream<Resource<bool>> get payBackCreditCardStream => _payBackCreditCardResponse.stream;

  CreditCardPayBackPageModel(this._payBackCreditCardUseCase, this.payBackArguments) {
    _payBackCreditCardRequest.listen((value) {
      RequestManager(value, createCall: () => _payBackCreditCardUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _payBackCreditCardResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });
  }

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

  void payBackCreditCard() {
    _payBackCreditCardRequest.safeAdd(PayBackCreditCardUseCaseParams(
        secureCode: payBackArguments.secureCode, payBackAmount: currentPinValue));
  }
}
