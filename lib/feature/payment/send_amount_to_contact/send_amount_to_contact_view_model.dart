import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:domain/model/payment/check_send_money_response.dart';
import 'package:domain/model/payment/transfer_respone.dart';
import 'package:domain/model/payment/transfer_success_response.dart';
import 'package:domain/model/purpose/purpose.dart';
import 'package:domain/model/purpose/purpose_detail.dart';
import 'package:domain/model/purpose/purpose_response.dart';
import 'package:domain/usecase/payment/check_send_money_usecase.dart';
import 'package:domain/usecase/payment/get_purpose_usecase.dart';
import 'package:domain/usecase/payment/send_amount_to_contact_usecase.dart';
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
  SendAmountToContactUseCase _useCase;

  GetPurposeUseCase _getPurposeUseCase;

  final Beneficiary beneficiary;

  PublishSubject<String> _purposeSubject = PublishSubject();

  Stream<String> get purposeStream => _purposeSubject.stream;

  BehaviorSubject<String> _purposeDetailSubject =
      BehaviorSubject.seeded('Transfer to Friend or Family');

  Stream<String> get purposeDetailStream => _purposeDetailSubject.stream;

  ///check send money request
  PublishSubject<CheckSendMoneyUseCaseParams> _checkSendMoneyRequest =
      PublishSubject();

  PublishSubject<GetPurposeUseCaseParams> _getPurposeRequest = PublishSubject();

  ///check send money response
  PublishSubject<Resource<CheckSendMoneyResponse>> _checkSendMoneyResponse =
      PublishSubject();

  ///check send money response stream
  Stream<Resource<CheckSendMoneyResponse>> get checkSendMoneyStream =>
      _checkSendMoneyResponse.stream;

  ///transfer request
  PublishSubject<TransferUseCaseParams> _transferRequest = PublishSubject();

  ///transfer response
  PublishSubject<Resource<TransferSuccessResponse>> _transferResponse =
      PublishSubject();

  ///transfer response stream
  Stream<Resource<TransferSuccessResponse>> get transferStream =>
      _transferResponse.stream;

  PublishSubject<Resource<PurposeResponse>> _getPurposeResponse =
      PublishSubject();

  Stream<Resource<PurposeResponse>> get getPurposeResponseStream =>
      _getPurposeResponse.stream;

  Purpose? purpose;

  PurposeDetail? purposeDetail;

  SendAmountToContactViewModel(
      this._useCase,
      this.beneficiary,
      this._checkSendMoneyUseCase,
      this._transferUseCase,
      this._getPurposeUseCase) {
    _checkSendMoneyRequest.listen((value) {
      RequestManager(value,
              createCall: () => _checkSendMoneyUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _checkSendMoneyResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _transferRequest.listen((value) {
      RequestManager(value,
              createCall: () => _transferUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _transferResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _getPurposeRequest.listen((value) {
      RequestManager(value,
              createCall: () => _getPurposeUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getPurposeResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });
    getPurpose();
  }

  void getPurpose() {
    _getPurposeRequest.safeAdd(GetPurposeUseCaseParams(
        toAccount: beneficiary.iban!, transferType: "TransferI"));
  }

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

  void updatePurposeDetail(String value) {
    _purposeDetailSubject.safeAdd(value);
  }

  void updatePurpose(String value) {
    _purposeSubject.safeAdd(value);
  }

  void checkSendMoney() {
    _checkSendMoneyRequest.safeAdd(CheckSendMoneyUseCaseParams(
        toAccount: beneficiary.accountNo!,
        toAmount: int.parse(currentPinValue)));
  }

  void transfer(TransferResponse transferResponse) {
    _transferRequest.safeAdd(TransferUseCaseParams(
      otpCode: '',
      toAmount: transferResponse.toAmount,
      toAccount: transferResponse.toAccount,
      memo: _purposeDetailSubject.value,
      isFriend: false,
      transferType: transferResponse.transferType,
      localEq: transferResponse.localEq,
      beneficiaryId: transferResponse.beneficiaryId,
      beneficiaryImage: transferResponse.beneficiaryImage,
    ));
  }

  @override
  void dispose() {
    _purposeDetailSubject.close();
    _purposeSubject.close();
    super.dispose();
  }
}
