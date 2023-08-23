import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:domain/model/payment/check_send_money_response.dart';
import 'package:domain/model/payment/transfer_respone.dart';
import 'package:domain/model/payment/transfer_success_response.dart';
import 'package:domain/model/purpose/purpose.dart';
import 'package:domain/model/purpose/purpose_detail.dart';
import 'package:domain/usecase/payment/check_send_money_usecase.dart';
import 'package:domain/usecase/payment/transfer_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class SendAmountToContactViewModel extends BasePageViewModel {
  final CheckSendMoneyUseCase _checkSendMoneyUseCase;
  final TransferUseCase _transferUseCase;

  final Beneficiary beneficiary;

  PublishSubject<String> _purposeSubject = PublishSubject();

  Stream<String> get purposeStream => _purposeSubject.stream;

  PublishSubject<String> _purposeDetailSubject = PublishSubject();

  Stream<String> get purposeDetailStream => _purposeDetailSubject.stream;

  ///check send money request
  PublishSubject<CheckSendMoneyUseCaseParams> _checkSendMoneyRequest = PublishSubject();

  ///check send money response
  PublishSubject<Resource<CheckSendMoneyResponse>> _checkSendMoneyResponse = PublishSubject();

  ///check send money response stream
  Stream<Resource<CheckSendMoneyResponse>> get checkSendMoneyStream => _checkSendMoneyResponse.stream;

  ///transfer request
  PublishSubject<TransferUseCaseParams> _transferRequest = PublishSubject();

  ///transfer response
  PublishSubject<Resource<TransferSuccessResponse>> _transferResponse = PublishSubject();

  ///transfer response stream
  Stream<Resource<TransferSuccessResponse>> get transferStream => _transferResponse.stream;

  Purpose? purpose;

  PurposeDetail? purposeDetail;

  List<Purpose>? purposeList = [];

  bool showBackButton = false;

  SendAmountToContactViewModel(this.beneficiary, this._checkSendMoneyUseCase, this._transferUseCase) {
    _checkSendMoneyRequest.listen((value) {
      RequestManager(value, createCall: () => _checkSendMoneyUseCase.execute(params: value)).asFlow().listen((event) {
        updateLoader();
        _checkSendMoneyResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _transferRequest.listen((value) {
      RequestManager(value, createCall: () => _transferUseCase.execute(params: value)).asFlow().listen((event) {
        updateLoader();
        _transferResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          // showToastWithError(event.appError!);
        }
      });
    });
  }

  setShowBackButton(bool needBackButton) {
    this.showBackButton = needBackButton;
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

  void updatePurposeDetail(PurposeDetail value) {
    purposeDetail = value;
    _purposeDetailSubject.safeAdd(value.labelEn!);
  }

  void updatePurpose(Purpose value) {
    purpose = value;
    _purposeSubject.safeAdd(value.labelEn!);
  }

  void checkSendMoney() {
    _checkSendMoneyRequest.safeAdd(CheckSendMoneyUseCaseParams(toAccount: beneficiary.identifier ?? '', toAmount: double.parse(currentPinValue), beneficiaryId: beneficiary.id ?? ''));
  }

  void transfer(TransferResponse transferResponse) {
    _transferRequest.safeAdd(TransferUseCaseParams(
        otpCode: '576824',
        toAmount: transferResponse.toAmount,
        toAccount: transferResponse.toAccount,
        limit: purposeDetail == null ? beneficiary.limit : purposeDetail!.limit,
        memo: purposeDetail == null ? (beneficiary.purpose == null ? '' : beneficiary.purpose!) : purposeDetail!.strCode!,
        isFriend: false,
        nickName: "",
        transferType: transferResponse.transferType,
        localEq: transferResponse.localEq,
        beneficiaryId: transferResponse.beneficiaryId,
        beneficiaryImage: "",
        type: "",
        detCustomerType: ""));
  }

  @override
  void dispose() {
    _purposeSubject.close();
    super.dispose();
  }
}
