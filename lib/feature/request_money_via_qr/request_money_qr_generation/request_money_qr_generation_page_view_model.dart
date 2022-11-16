import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/request_money_via_qr/request_money_qr_generation/request_money_qr_generation_page.dart';

class RequestMoneyQrGenerationPageViewModel extends BasePageViewModel {
  final RequestMoneyQrGenerationPageArguments arguments;

  RequestMoneyQrGenerationPageViewModel(this.arguments);

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
    notifyListeners();
  }
}
