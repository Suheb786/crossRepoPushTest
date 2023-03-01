import 'package:domain/model/qr/qr_response.dart';
import 'package:domain/usecase/payment/generate_qr_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/request_money_via_qr/request_money_qr_generation/request_money_qr_generation_page.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class RequestMoneyQrGenerationPageViewModel extends BasePageViewModel {
  final RequestMoneyQrGenerationPageArguments arguments;
  final GenerateQRUseCase generateQRUseCase;

  ///---------------Generate QR----------------------///
  PublishSubject<GenerateQRUseCaseParams> _generateQRRequest = PublishSubject();

  PublishSubject<Resource<QrResponse>> _generateQRResponse = PublishSubject();

  Stream<Resource<QrResponse>> get generateQRStream => _generateQRResponse.stream;

  void generateQR() {
    _generateQRRequest.safeAdd(GenerateQRUseCaseParams(amount: currentPinValue));
  }

  ///---------------Generate QR----------------------///

  RequestMoneyQrGenerationPageViewModel(this.arguments, this.generateQRUseCase) {
    _generateQRRequest.listen((value) {
      RequestManager(value, createCall: () => generateQRUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _generateQRResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });
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
    notifyListeners();
  }
}
