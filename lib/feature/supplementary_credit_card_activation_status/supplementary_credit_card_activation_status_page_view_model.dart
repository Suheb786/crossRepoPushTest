import 'package:domain/model/card/supplementary_credit_card/supplementary_credit_card_application_response.dart';
import 'package:domain/usecase/card_delivery/get_supplementary_credit_card_application_usecase.dart';
import 'package:domain/usecase/card_delivery/supplementary_credit_card_step_three_usecase.dart';
import 'package:domain/usecase/card_delivery/supplementary_credit_card_step_two_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/supplementary_credit_card_activation_status/supplementary_credit_card_activation_status_page.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class SupplementaryCreditCardActivationStatusPageViewModel
    extends BasePageViewModel {
  final GetSupplementaryCreditCardApplicationUseCase
      _getSupplementaryCreditCardApplicationUseCase;

  final SupplementaryCreditCardStepTwoUseCase
      _supplementaryCreditCardStepTwoUseCase;

  final SupplementaryCreditCardStepThreeUseCase
      _supplementaryCreditCardStepThreeUseCase;

  final SupplementaryCreditCardActivationArguments arguments;

  ///get application request
  PublishSubject<GetSupplementaryCreditCardApplicationUseCaseParams>
      _getSupplementaryCreditCardApplicationRequest = PublishSubject();

  ///get application response
  PublishSubject<Resource<SupplementaryCreditCardApplicationResponse>>
      _getApplicationResponse = PublishSubject();

  ///get application response stream
  Stream<Resource<SupplementaryCreditCardApplicationResponse>>
      get getApplicationResponseStream => _getApplicationResponse.stream;

  ///supplementary credit card step two request
  PublishSubject<SupplementaryCreditCardStepTwoUseCaseParams>
      _supplementaryCreditCardStepTwoRequest = PublishSubject();

  ///supplementary credit card step two response
  PublishSubject<Resource<bool>> _supplementaryCreditCardStepTwoResponse =
      PublishSubject();

  ///supplementary credit card step two response stream
  Stream<Resource<bool>> get supplementaryCreditCardStepTwoResponseStream =>
      _supplementaryCreditCardStepTwoResponse.stream;

  ///supplementaryCreditCard step three request
  PublishSubject<SupplementaryCreditCardStepThreeUseCaseParams>
      _supplementaryCreditcardStepThreeRequest = PublishSubject();

  ///supplementaryCreditCard step three response
  PublishSubject<Resource<bool>> _supplementaryCreditcardStepThreeResponse =
      PublishSubject();

  ///supplementaryCreditCard step three response stream
  Stream<Resource<bool>> get supplementaryCreditcardStepThreeStream =>
      _supplementaryCreditcardStepThreeResponse.stream;

  SupplementaryCreditCardActivationStatusPageViewModel(
      this._getSupplementaryCreditCardApplicationUseCase,
      this._supplementaryCreditCardStepTwoUseCase,
      this._supplementaryCreditCardStepThreeUseCase,
      this.arguments) {
    _getSupplementaryCreditCardApplicationRequest.listen((value) {
      RequestManager(value,
          createCall: () => _getSupplementaryCreditCardApplicationUseCase
              .execute(params: value)).asFlow().listen((event) {
        _getApplicationResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    _supplementaryCreditCardStepTwoRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _supplementaryCreditCardStepTwoUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _supplementaryCreditCardStepTwoResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    _supplementaryCreditcardStepThreeRequest.listen((value) {
      RequestManager(value,
          createCall: () => _supplementaryCreditCardStepThreeUseCase.execute(
              params: value)).asFlow().listen((event) {
        _supplementaryCreditcardStepThreeResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    getApplication();
  }

  void getApplication() {
    _getSupplementaryCreditCardApplicationRequest.safeAdd(
        GetSupplementaryCreditCardApplicationUseCaseParams(
            primaryCard: arguments.primaryCardId));
  }

  void supplementaryCreditCardStepTwoRequest(
      {String? cardId, String? secondaryId}) {
    _supplementaryCreditCardStepTwoRequest.safeAdd(
        SupplementaryCreditCardStepTwoUseCaseParams(
            primaryCardId: cardId, secondaryCardId: secondaryId));
  }

  void supplementaryCreditCardStepThree(
      {String? cardId, String? accountNumber, String? secondaryId}) {
    _supplementaryCreditcardStepThreeRequest.safeAdd(
        SupplementaryCreditCardStepThreeUseCaseParams(
            accountNumber: accountNumber,
            secondaryCardId: secondaryId,
            primaryCardId: cardId));
  }

  @override
  void dispose() {
    _getSupplementaryCreditCardApplicationRequest.close();
    _getApplicationResponse.close();
    super.dispose();
  }
}
