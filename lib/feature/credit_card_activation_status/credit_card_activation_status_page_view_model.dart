import 'package:domain/model/card/get_card_applications/get_card_application_response.dart';
import 'package:domain/usecase/apply_credit_card/process_loan_step_usecase.dart';
import 'package:domain/usecase/card_delivery/credit_card_request_usecase.dart';
import 'package:domain/usecase/card_delivery/get_card_application_usecase.dart';
import 'package:domain/usecase/card_delivery/link_card_step_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class CreditCardActivationStatusPageViewModel extends BasePageViewModel {
  final GetCardApplicationUseCase _getCardApplicationUseCase;

  final CreditCardRequestUseCase _creditCardRequestUseCase;

  final LinkCardStepUseCase _linkCardStepUseCase;

  final ProcessLoanStepUseCase _processLoanStepUseCase;

  ///get application request
  PublishSubject<GetCardApplicationUseCaseParams> _getApplicationRequest = PublishSubject();

  ///get application response
  BehaviorSubject<Resource<GetCardApplicationResponse>> _getApplicationResponse = BehaviorSubject();

  ///get application response stream
  Stream<Resource<GetCardApplicationResponse>> get getApplicationResponseStream =>
      _getApplicationResponse.stream;

  ///credit card request
  PublishSubject<CreditCardRequestUseCaseParams> _creditCardReqRequest = PublishSubject();

  ///credit card response
  PublishSubject<Resource<bool>> _creditCardReqResponse = PublishSubject();

  ///credit card response stream
  Stream<Resource<bool>> get creditCardReqResponseStream => _creditCardReqResponse.stream;

  ///link card step request
  PublishSubject<LinkCardStepUseCaseParams> _linkCardStepRequest = PublishSubject();

  ///link card step response
  PublishSubject<Resource<bool>> _linkCardStepResponse = PublishSubject();

  ///link card step response stream
  Stream<Resource<bool>> get linkCardStepStream => _linkCardStepResponse.stream;

  ///process loan step request
  PublishSubject<ProcessLoanStepUseCaseParams> _processLoanStepRequest = PublishSubject();

  ///process loan step response
  PublishSubject<Resource<bool>> _processLoanStepResponse = PublishSubject();

  ///process loan step response stream
  Stream<Resource<bool>> get processLoanStepStream => _processLoanStepResponse.stream;

  bool isFirstLoad = true;

  CreditCardActivationStatusPageViewModel(this._getCardApplicationUseCase, this._creditCardRequestUseCase,
      this._linkCardStepUseCase, this._processLoanStepUseCase) {
    _getApplicationRequest.listen((value) {
      RequestManager(value, createCall: () => _getCardApplicationUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        if (isFirstLoad) {
          updateLoader();
        }

        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          isFirstLoad = false;
          _getApplicationResponse.safeAdd(event);
        }
      });
    });

    _creditCardReqRequest.listen((value) {
      RequestManager(value, createCall: () => _creditCardRequestUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        // updateLoader();
        _creditCardReqResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _linkCardStepRequest.listen((value) {
      RequestManager(value, createCall: () => _linkCardStepUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        //updateLoader();
        _linkCardStepResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    _processLoanStepRequest.listen((value) {
      RequestManager(value, createCall: () => _processLoanStepUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        //updateLoader();
        _processLoanStepResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    getApplication();
  }

  void getApplication() {
    _getApplicationRequest.safeAdd(GetCardApplicationUseCaseParams());
  }

  void creditCardRequest(String cardId) {
    _creditCardReqRequest.safeAdd(CreditCardRequestUseCaseParams(cardId: cardId));
  }

  void linkCardStep(String cardId, String accountNumber) {
    _linkCardStepRequest.safeAdd(LinkCardStepUseCaseParams(cardId: cardId, accountNumber: accountNumber));
  }

  void processLoanStep(String cardId, num loanValueId) {
    _processLoanStepRequest.safeAdd(ProcessLoanStepUseCaseParams(cardId: cardId, loanValueId: loanValueId));
  }

  @override
  void dispose() {
    _getApplicationRequest.close();
    _getApplicationResponse.close();
    super.dispose();
  }
}
