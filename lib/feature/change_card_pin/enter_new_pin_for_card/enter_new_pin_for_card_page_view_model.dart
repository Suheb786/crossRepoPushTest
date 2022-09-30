import 'package:domain/constants/enum/card_type.dart';
import 'package:domain/usecase/card_delivery/change_debit_pin_verify_usecase.dart';
import 'package:domain/usecase/card_delivery/credit_card_change_pin_verify_usecase.dart';
import 'package:domain/usecase/card_delivery/enter_new_pin_for_card_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class EnterNewPinForCardPageViewModel extends BasePageViewModel {
  final EnterNewPinForCardUseCase _enterNewPinForCardUsecase;

  final ChangeDebitPinVerifyUseCase _changeDebitPinVerifyUseCase;

  final CreditCardChangePinVerifyUseCase _creditCardChangePinVerifyUseCase;

  TextEditingController newPinController = TextEditingController();
  TextEditingController confirmPinController = TextEditingController();
  final GlobalKey<AppTextFieldState> newPinKey = GlobalKey(debugLabel: "new-pin");
  final GlobalKey<AppTextFieldState> confirmPinKey = GlobalKey(debugLabel: "confirm-pin");

  ///enter new pin for card request subject holder
  PublishSubject<EnterNewPinForCardUseCaseParams> _enterNewPinForCardRequest = PublishSubject();

  ///enter new pin for card response holder
  PublishSubject<Resource<bool>> _enterNewPinForCardResponse = PublishSubject();

  ///enter new pin for card stream
  Stream<Resource<bool>> get enterNewPinForCardStream => _enterNewPinForCardResponse.stream;

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  ///change debit card pin verify request subject holder
  PublishSubject<ChangeDebitPinVerifyUseCaseParams> _changeDebitPinVerifyRequest = PublishSubject();

  ///change debit card pin verify response holder
  PublishSubject<Resource<bool>> _changeDebitPinVerifyResponse = PublishSubject();

  ///change debit card pin verify stream
  Stream<Resource<bool>> get changeDebitPinVerifyStream => _changeDebitPinVerifyResponse.stream;

  ///---------------change credit card pin verify -----------------------///

  PublishSubject<CreditCardChangePinVerifyUseCaseParams> _creditCardChangePinVerifyRequest = PublishSubject();

  PublishSubject<Resource<bool>> _creditCardChangePinVerifyResponse = PublishSubject();

  Stream<Resource<bool>> get creditCardChangePinVerifyStream => _creditCardChangePinVerifyResponse.stream;

  void changeCreditCardPinVerify({required String cardCode}) {
    _creditCardChangePinVerifyRequest.safeAdd(CreditCardChangePinVerifyUseCaseParams(cardCode: cardCode));
  }

  ///---------------change credit card pin verify -----------------------///

  EnterNewPinForCardPageViewModel(this._enterNewPinForCardUsecase, this._changeDebitPinVerifyUseCase,
      this._creditCardChangePinVerifyUseCase) {
    _enterNewPinForCardRequest.listen((value) {
      RequestManager(value, createCall: () => _enterNewPinForCardUsecase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _enterNewPinForCardResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _changeDebitPinVerifyRequest.listen((value) {
      RequestManager(value, createCall: () => _changeDebitPinVerifyUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _changeDebitPinVerifyResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    _creditCardChangePinVerifyRequest.listen((value) {
      RequestManager(value, createCall: () => _creditCardChangePinVerifyUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _creditCardChangePinVerifyResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });
  }

  void enterNewPinForCard(CardType cardType) {
    _enterNewPinForCardRequest.safeAdd(EnterNewPinForCardUseCaseParams(
        pin: newPinController.text, confirmPin: confirmPinController.text, cardType: cardType));
  }

  void changeDebitPinVerify() {
    _changeDebitPinVerifyRequest.safeAdd(ChangeDebitPinVerifyUseCaseParams());
  }

  void validate() {
    if (newPinController.text.isNotEmpty && confirmPinController.text.isNotEmpty) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  @override
  void dispose() {
    _enterNewPinForCardRequest.close();
    _enterNewPinForCardResponse.close();
    _showButtonSubject.close();
    super.dispose();
  }
}
