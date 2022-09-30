import 'package:domain/constants/enum/card_type.dart';
import 'package:domain/usecase/card_delivery/credit_card_pin_unblock_usecase.dart';
import 'package:domain/usecase/card_delivery/unblock_debit_card_pin_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/manage_card_pin/manage_card_pin_page.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class ManageCardPinViewModel extends BasePageViewModel {
  final ManageCardPinArguments? manageCardPinArguments;
  final UnblockDebitCardPinUseCase _unblockDebitCardPinUseCase;
  final CreditCardPinUnblockUseCase _unblockCreditCardPinUseCase;

  PublishSubject<UnblockDebitCardPinUseCaseParams> _unblockDebitCardRequestSubject = PublishSubject();

  PublishSubject<CreditCardPinUnblockUseCaseParams> _unblockCreditCardRequestSubject = PublishSubject();

  PublishSubject<Resource<bool>> _unblockCardPinResponseSubject = PublishSubject();

  Stream<Resource<bool>> get unblockCardPinStream => _unblockCardPinResponseSubject.stream;

  ManageCardPinViewModel(
      this.manageCardPinArguments, this._unblockDebitCardPinUseCase, this._unblockCreditCardPinUseCase) {
    _unblockCreditCardRequestSubject.listen((value) {
      RequestManager(value, createCall: () => _unblockCreditCardPinUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _unblockCardPinResponseSubject.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    _unblockDebitCardRequestSubject.listen((value) {
      RequestManager(value, createCall: () => _unblockDebitCardPinUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _unblockCardPinResponseSubject.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });
  }

  void unBlockPin({
    required String pinCode,
    required String tokenizedPan,
  }) {
    if (manageCardPinArguments!.cardType == CardType.CREDIT) {
      unBlockCreditCardPin(cardCode: tokenizedPan);
    } else if (manageCardPinArguments!.cardType == CardType.DEBIT) {
      unBlockDebitCardPin(pinCode: pinCode, tokenizedPan: tokenizedPan);
    }
  }

  void unBlockCreditCardPin({required String cardCode}) {
    _unblockCreditCardRequestSubject.safeAdd(CreditCardPinUnblockUseCaseParams(cardCode: cardCode));
  }

  void unBlockDebitCardPin({
    required String pinCode,
    required String tokenizedPan,
  }) {
    _unblockDebitCardRequestSubject.safeAdd(UnblockDebitCardPinUseCaseParams(pin: '', status: tokenizedPan));
  }

  @override
  void dispose() {
    _unblockDebitCardRequestSubject.close();
    _unblockCreditCardRequestSubject.close();
    _unblockCardPinResponseSubject.close();
    super.dispose();
  }
}
