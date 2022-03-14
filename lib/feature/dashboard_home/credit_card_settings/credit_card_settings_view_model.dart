import 'package:domain/model/card/get_card_applications/get_card_application_response.dart';
import 'package:domain/usecase/card_delivery/cancel_credit_card_usecase.dart';
import 'package:domain/usecase/card_delivery/freeze_credit_card_usecase.dart';
import 'package:domain/usecase/card_delivery/get_supplementary_credit_card_application_usecase.dart';
import 'package:domain/usecase/card_delivery/unfreeze_credit_card_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/credit_card_settings/credit_card_settings_page.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class CreditCardSettingsViewModel extends BasePageViewModel {
  final CreditCardSettingsArguments creditCardSettingsArguments;
  final FreezeCreditCardUseCase _freezeCreditCardUseCase;
  final UnFreezeCreditCardUseCase _unFreezeCreditCardUseCase;
  final CancelCreditCardUseCase _cancelCreditCardUseCase;
  final GetSupplementaryCreditCardApplicationUseCase
      _getSupplementaryCreditCardApplicationUseCase;

  PublishSubject<bool> _toggleFreezeCardSubject = PublishSubject();

  Stream<bool> get freezeCardStream => _toggleFreezeCardSubject.stream;

  PublishSubject<FreezeCreditCardUseCaseParams> _freezeCardRequestSubject =
      PublishSubject();
  PublishSubject<Resource<bool>> _toggleFreezeCardSubjectResponse =
      PublishSubject();

  Stream<Resource<bool>> get toggleFreezeCardStream =>
      _toggleFreezeCardSubjectResponse.stream;

  PublishSubject<UnFreezeCreditCardUseCaseParams> _unFreezeCardRequestSubject =
      PublishSubject();

  ///cancel credit card
  PublishSubject<CancelCreditCardUseCaseParams>
      _cancelCreditCardRequestSubject = PublishSubject();

  PublishSubject<Resource<bool>> _cancelCreditCardResponseSubject =
      PublishSubject();

  Stream<Resource<bool>> get cancelCreditCardStream =>
      _cancelCreditCardResponseSubject.stream;

  bool isFreezed = false;
  bool isUnFreezed = false;
  bool isCancelled = false;

  ///show dialog
  PublishSubject<bool> _showDialogRequestSubject = PublishSubject();

  Stream<bool> get showDialogStream => _showDialogRequestSubject.stream;

  ///get supplementary credit card application use case
  PublishSubject<GetSupplementaryCreditCardApplicationUseCaseParams>
      _getSupplementaryCreditCardApplicationRequestSubject = PublishSubject();

  PublishSubject<Resource<GetCardApplicationResponse>>
      _getSupplementaryCreditCardApplicationResponseSubject = PublishSubject();

  Stream<Resource<GetCardApplicationResponse>>
      get getSupplementaryCreditCardApplicationStream =>
          _getSupplementaryCreditCardApplicationResponseSubject.stream;

  CreditCardSettingsViewModel(
      this._freezeCreditCardUseCase,
      this._unFreezeCreditCardUseCase,
      this._cancelCreditCardUseCase,
      this.creditCardSettingsArguments,
      this._getSupplementaryCreditCardApplicationUseCase) {
    _freezeCardRequestSubject.listen((value) {
      RequestManager(value,
              createCall: () => _freezeCreditCardUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _toggleFreezeCardSubjectResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          _toggleFreezeCardSubject.safeAdd(false);
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          _toggleFreezeCardSubject.safeAdd(true);
          isFreezed = true;
        }
      });
    });

    _unFreezeCardRequestSubject.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _unFreezeCreditCardUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _toggleFreezeCardSubjectResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          _toggleFreezeCardSubject.safeAdd(true);
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          _toggleFreezeCardSubject.safeAdd(false);
          isUnFreezed = true;
        }
      });
    });

    _cancelCreditCardRequestSubject.listen((value) {
      RequestManager(value,
              createCall: () => _cancelCreditCardUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _cancelCreditCardResponseSubject.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          isCancelled = true;
        }
      });
    });

    _getSupplementaryCreditCardApplicationRequestSubject.listen((value) {
      RequestManager(value,
          createCall: () => _getSupplementaryCreditCardApplicationUseCase
              .execute(params: value)).asFlow().listen((event) {
        updateLoader();
        _getSupplementaryCreditCardApplicationResponseSubject.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });
  }

  void toggleFreezeCardStatus(bool value) {
    _toggleFreezeCardSubject.safeAdd(value);
  }

  void freezeCardStatus(bool value) {
    _toggleFreezeCardSubject.safeAdd(value);
  }

  void freezeCard(String cardID) {
    _freezeCardRequestSubject
        .safeAdd(FreezeCreditCardUseCaseParams(cardId: cardID));
  }

  void unFreezeCard(String cardID) {
    _unFreezeCardRequestSubject
        .safeAdd(UnFreezeCreditCardUseCaseParams(cardId: cardID));
  }

  void cancelCard(String reason) {
    _cancelCreditCardRequestSubject
        .safeAdd(CancelCreditCardUseCaseParams(reason: reason));
  }

  bool willPop() {
    bool pop = false;
    if (isFreezed || isUnFreezed || isCancelled) {
      pop = true;
    }
    return pop;
  }

  void updateShowDialog(bool value) {
    _showDialogRequestSubject.safeAdd(value);
  }

  void getSupplementaryCreditCardApplication() {
    _getSupplementaryCreditCardApplicationRequestSubject.safeAdd(
        GetSupplementaryCreditCardApplicationUseCaseParams(
            primaryCard: creditCardSettingsArguments.creditCard.cardId));
  }

  @override
  void dispose() {
    _toggleFreezeCardSubject.close();
    _freezeCardRequestSubject.close();
    _unFreezeCardRequestSubject.close();
    _toggleFreezeCardSubjectResponse.close();
    _cancelCreditCardResponseSubject.close();
    super.dispose();
  }
}
