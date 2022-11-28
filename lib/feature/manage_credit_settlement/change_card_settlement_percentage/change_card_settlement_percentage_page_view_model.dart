import 'package:domain/usecase/update_settlement/update_settlement_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/manage_credit_settlement/change_card_settlement_percentage/change_card_settlement_percentage_page.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class ChangeCardSettlementPercentagePageViewModel extends BasePageViewModel {
  UpdateSettlementUseCase _updateSettlementUseCase;
  ChangeCardSettlementPercentageArguments? arguments;

  ///controllers and keys
  final TextEditingController settlementPercentageController = TextEditingController();
  final GlobalKey<AppTextFieldState> settlementPercentageKey = GlobalKey(debugLabel: "settlementPercentage");

  List<String> percentageList = ["25 %", "50 %", "100 %"];

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  PublishSubject<UpdateSettlementUseCaseParams> _updateSettlementRequest = PublishSubject();

  PublishSubject<Resource<bool>> _updateSettlementResponse = PublishSubject();

  Stream<Resource<bool>> get updateSettlementStream => _updateSettlementResponse.stream;

  ChangeCardSettlementPercentagePageViewModel(this._updateSettlementUseCase) {
    settlementPercentageController.text = percentageList.first;
    _updateSettlementRequest.listen((value) {
      RequestManager(value, createCall: () => _updateSettlementUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _updateSettlementResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });
  }

  void updateSettlement() {
    _updateSettlementRequest.safeAdd(UpdateSettlementUseCaseParams(
        cardId: arguments!.creditCard.cardId,
        rate: int.parse(settlementPercentageController.text.replaceAll("%", ""))));
  }

  void validate() {
    if (settlementPercentageController.text.isNotEmpty) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }
}
