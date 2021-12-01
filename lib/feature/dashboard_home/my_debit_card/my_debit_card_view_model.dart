import 'package:domain/usecase/dashboard/my_debit_card_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class MyDebitCardViewModel extends BasePageViewModel {
  MyDebitCardUseCase _useCase;

  BehaviorSubject<bool> _isFlipCardClickedSubject =
      BehaviorSubject.seeded(false);

  Stream<bool> get isGetCardNowClickedStream =>
      _isFlipCardClickedSubject.stream;

  MyDebitCardViewModel(this._useCase);

  void updateIsGetCardNowClicked(bool value) {
    _isFlipCardClickedSubject.safeAdd(value);
  }

  @override
  void dispose() {
    super.dispose();
    _isFlipCardClickedSubject.close();
  }
}
