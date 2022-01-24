import 'package:domain/constants/enum/card_type.dart';
import 'package:domain/usecase/card_delivery/change_debit_card_pin_usecase.dart';
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

  final ChangeDebitCardPinUseCase _changeDebitCardPinUseCase;

  TextEditingController newPinController = TextEditingController();
  TextEditingController confirmPinController = TextEditingController();
  final GlobalKey<AppTextFieldState> newPinKey =
      GlobalKey(debugLabel: "new-pin");
  final GlobalKey<AppTextFieldState> confirmPinKey =
      GlobalKey(debugLabel: "confirm-pin");

  ///enter new pin for card request subject holder
  PublishSubject<EnterNewPinForCardUseCaseParams> _enterNewPinForCardRequest =
      PublishSubject();

  ///enter new pin for card response holder
  PublishSubject<Resource<bool>> _enterNewPinForCardResponse = PublishSubject();

  ///enter new pin for card stream
  Stream<Resource<bool>> get enterNewPinForCardStream =>
      _enterNewPinForCardResponse.stream;

  ///change debit card pin request subject holder
  PublishSubject<ChangeDebitCardPinUseCaseParams> _changDebitCardPinRequest =
      PublishSubject();

  ///change debit card pin response holder
  PublishSubject<Resource<bool>> _changDebitCardPinResponse = PublishSubject();

  ///change debit card pin stream
  Stream<Resource<bool>> get changDebitCardPinStream =>
      _changDebitCardPinResponse.stream;

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  EnterNewPinForCardPageViewModel(
      this._enterNewPinForCardUsecase, this._changeDebitCardPinUseCase) {
    _enterNewPinForCardRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _enterNewPinForCardUsecase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _enterNewPinForCardResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });

    _changDebitCardPinRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _changeDebitCardPinUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _changDebitCardPinResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });
  }

  void enterNewPinForCard(CardType cardType) {
    _enterNewPinForCardRequest.safeAdd(EnterNewPinForCardUseCaseParams(
        pin: newPinController.text,
        confirmPin: confirmPinController.text,
        cardType: cardType));
  }

  void changeDebitCardPin(
      {required String pin,
      required String otp,
      required String tokenizedPan}) {
    _changDebitCardPinRequest.safeAdd(ChangeDebitCardPinUseCaseParams(
        pin: pin, otp: otp, tokenizedPan: tokenizedPan));
  }

  void validate() {
    if (newPinController.text.isNotEmpty &&
        confirmPinController.text.isNotEmpty) {
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
