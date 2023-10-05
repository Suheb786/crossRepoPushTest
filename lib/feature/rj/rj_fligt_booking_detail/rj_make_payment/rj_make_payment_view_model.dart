import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:domain/usecase/rj/rj_otp_validate.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class RjMakePaymentViewModel extends BasePageViewModel {
  final RJOtpValidateUseCase _rjOtpValidateUseCase;

  ///---------------Rj OTP Validate Details----------------------///
  PublishSubject<RJOtpValidateUseCaseParams> _rjOtpValidateRequest = PublishSubject();

  PublishSubject<Resource<bool>> _rjOtpValidateResponse = PublishSubject();

  Stream<Resource<bool>> get rjOtpValidateStream => _rjOtpValidateResponse.stream;

  PublishSubject<Account> _selectedFromAccountSubject = PublishSubject();

  Stream<Account> get selectedFromAccountStream => _selectedFromAccountSubject.stream;

  List<Account> allAccountList = [];
  List<Account> _fromAccountList = [];

  List<Account> get getAllFromList => _fromAccountList;

  void addFromAccountData({Account? account}) {
    selectedAccount = account;
    _selectedFromAccountSubject.safeAdd(selectedAccount);
  }

  void rjOtpValidate() {
    _rjOtpValidateRequest.safeAdd(RJOtpValidateUseCaseParams());
  }

  Account? selectedAccount;

  ///---------------Rj OTP Validate Details----------------------///

  RjMakePaymentViewModel(this._rjOtpValidateUseCase) {
    _rjOtpValidateRequest.listen((value) {
      RequestManager(value, createCall: () => _rjOtpValidateUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _rjOtpValidateResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });
  }

  List<MakePaymentCard> makePaymentCardList = [];
  PublishSubject<List<MakePaymentCard>> _itemSelectedSubject = PublishSubject();

  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject();

  Stream<bool> get showButtonSubjectStream => _showButtonSubject.stream;

  @override
  void dispose() {
    super.dispose();
  }

  MakePaymentCard? selectedCard;

  void addMakePaymentItem({required List<MakePaymentCard> cardList}) {
    makePaymentCardList = cardList;
    _itemSelectedSubject.safeAdd(cardList);
  }

// void selectedItem(int index) {
//   if (makePaymentCardList.isNotEmpty) {
//     makePaymentCardList.forEach((element) {
//       element.isSelected = false;
//     });
//     makePaymentCardList[index].isSelected = true;
//   }
//   _itemSelectedSubject.safeAdd(makePaymentCardList);
//   selectedCard = makePaymentCardList.firstWhere((element) => element.isSelected ?? false);
//   _showButtonSubject.safeAdd(true);
// }
}

class MakePaymentCard {
  final String? cardName;
  final String? cardNo;
  final int? amt;
  final String? currency;
  bool? isSelected;

  MakePaymentCard({this.cardName, this.cardNo, this.amt, this.currency, this.isSelected});
}
